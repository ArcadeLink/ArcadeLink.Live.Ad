import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:http/http.dart' as http;
import 'image_text.dart';

Future<void> main() async {
  runApp(const AdvertisementApp());

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1040, 260),
    center: true,
    title: 'ArcadeLink Advertisement',
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.minimize();
  });
}

class AdvertisementApp extends StatelessWidget {
  const AdvertisementApp({super.key});

  // 1,040 × 260 Window Size
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArcadeLink Advertisement',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'ArcadeLink Advertisement'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _pageController;
  late Timer _timer;

  Future<List<dynamic>> fetchData(String qth, String secret) async {
    final response = await http.get(
      Uri.parse('https://api.arcade-link.top/announcements'),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      var data = jsonDecode(response.body)["data"];
      
      // Filter all announcement which id is equal to qth
      data = data.where((element) => element["location"] == qth.toString() || element["location"] == "0").toList();
      
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Map<String, String>> _data = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.page == _data.length - 1) {
        _pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
      }
    });

    initData();

  }


  Future<void> initData() async {
    var pref = await SharedPreferences.getInstance();

    if(!pref.containsKey("qth") || !pref.containsKey("secret")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先填写机台信息'),
          action: SnackBarAction(
            label: '填写',
            onPressed: () {
              // 弹窗
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('填写机台信息'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: '机厅ID',
                          ),
                          onChanged: (value) {
                            pref.setString("qth", value);
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: '机台密钥',
                          ),
                          onChanged: (value) {
                            pref.setString("secret", value);
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          initData();
                        },
                        child: const Text('确定'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ),
      );
      return;
    }

    var qth = pref.getString("qth");
    var secret = pref.getString("secret");
    var data = await fetchData(qth!, secret!);
    setState(() {
      _data.clear();
      for (var i = 0; i < data.length; i++) {
        if(data[i]["image"] == null){
          data[i]["image"] = "";
        }

        _data.add({
          'imageUrl': data[i]['image'],
          'title': data[i]['title'],
          'content': data[i]['content'],
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return ImageAndText(
              imageUrl: _data[index]['imageUrl']!,
              title: _data[index]['title']!,
              details: _data[index]['content']!,
            );
          },
        ),
      ),
    );
  }


}
