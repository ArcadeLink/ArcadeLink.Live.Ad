import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageAndText extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String details;

  const ImageAndText({super.key, required this.imageUrl, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20), // Add some spacing
        Expanded(
          flex: 3,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(width: 10), // Add some spacing
        Expanded(
          flex: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                details,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}