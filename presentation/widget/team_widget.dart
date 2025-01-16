import 'package:flutter/material.dart';

class TeamWidget extends StatelessWidget {
  final String imagePath;
  final String? text;
  final double imageWidth;
  final double imageHeight;
  final TextStyle? textStyle;
  final Color? color;

  const TeamWidget({
    super.key,
    required this.imagePath,
    this.text,
    required this.imageWidth,
    required this.imageHeight,
    this.textStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 8.0),
        Text(
          text!,
          style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.normal, color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
