//Packages
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RoundedImageNetwork extends StatelessWidget {
  final String imagePath;
  final double size;

  RoundedImageNetwork({
    required Key key,
    required this.imagePath,
    required this.size,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: Colors.white,
      ),
    );
  }
}

class RoundedImageFile extends StatelessWidget {
  final PlatformFile image;
  final double size;
  RoundedImageFile({required Key key, required this.image, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(image.path!)),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: Colors.white,
      ),
    );
  }
}

class RoundedImageNetworkWithStatusIndicator extends RoundedImageNetwork {
  final bool isActive;
  RoundedImageNetworkWithStatusIndicator({
    required key,
    required String imagePath,
    required double size,
    required this.isActive,
  }) : super(key: key, imagePath: imagePath, size: size);
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        super.build(context),
        Container(
          height: size * 0.2,
          width: size * 0.2,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      ],
    );
  }
}
