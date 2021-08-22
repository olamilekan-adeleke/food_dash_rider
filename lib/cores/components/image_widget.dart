import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/emums.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    Key? key,
    required this.imageUrl,
    required this.imageTypes,
  }) : super(key: key);

  final String imageUrl;
  final ImageTypes imageTypes;

  @override
  Widget build(BuildContext context) {
    switch (imageTypes) {
      case ImageTypes.network:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          errorWidget: (_, __, ___) => const Center(child: Icon(Icons.error)),
          placeholder: (_, __) =>
              const Center(child: CircularProgressIndicator()),
        );

      case ImageTypes.file:
        return Image.file(
          File(imageUrl),
          fit: BoxFit.fill,
          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.error)),
        );
      case ImageTypes.asset:
        return Image.asset(
          imageUrl,
          fit: BoxFit.fill,
          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.error)),
        );

      case ImageTypes.none:
        return const Placeholder();
    }
  }
}
