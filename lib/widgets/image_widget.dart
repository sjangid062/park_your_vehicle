import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imagePath, this.width, this.height});

  final String imagePath;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath, width: width, height: height);
  }
}
