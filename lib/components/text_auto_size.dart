import 'package:flutter/material.dart';

class TextAutoSize extends StatelessWidget {
  final String text;
  final double minLegth;
  final TextStyle? style;
  const TextAutoSize(this.text,
      {super.key, required this.minLegth, required this.style});

  @override
  Widget build(BuildContext context) {
    double? size = style?.fontSize;
    if (text.length >= minLegth) {
      size = minLegth * 3;
    }

    return Text(
      text,
      style: style?.copyWith(fontSize: size),
    );
  }
}
