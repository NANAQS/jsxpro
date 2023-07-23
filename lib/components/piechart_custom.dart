import 'dart:math';

import 'package:flutter/material.dart';

class PieChartCustom extends StatelessWidget {
  final double porcentagem;
  final Size size;

  const PieChartCustom(
      {super.key, required this.porcentagem, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _PiePainter(porcentagem, context),
    );
  }
}

class _PiePainter extends CustomPainter {
  final double porcent;
  final BuildContext context;

  _PiePainter(this.porcent, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = min(centerX, centerY);

    final paintbg = Paint()
      ..color = Theme.of(context).colorScheme.inversePrimary
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -pi / 2,
      100,
      true,
      paintbg,
    );

    final paint = Paint()
      ..color = Theme.of(context).colorScheme.primary
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -pi / 2,
      2 * pi * porcent,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
