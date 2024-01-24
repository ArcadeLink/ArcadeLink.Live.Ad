import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  runApp(const AdvertisementApp());

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1040, 260),
    center: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

class AdvertisementApp extends StatelessWidget {
  const AdvertisementApp({super.key});

  // 1,040 × 260 Window Size
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALLS Advertisement',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'ALLS Advertisement'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Icon(Icons.ac_unit),
            Column(children: [
              Text('公告标题啊哇哇哇', style: TextStyle(),),
              Text("公告内容啊哇哇哇挖挖挖安慰啊的大雾无梦递茶")
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
