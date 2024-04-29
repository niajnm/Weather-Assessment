import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3316667, size.height * 0.5728571);
    path_0.quadraticBezierTo(size.width * 0.3347917, size.height * 0.5364286,
        size.width * 0.4283333, size.height * 0.4985714);
    path_0.quadraticBezierTo(size.width * 0.4237500, size.height * 0.5660714,
        size.width * 0.4583333, size.height * 0.5771429);
    path_0.quadraticBezierTo(size.width * 0.4931250, size.height * 0.5603571,
        size.width * 0.4858333, size.height * 0.5000000);
    path_0.quadraticBezierTo(size.width * 0.5662500, size.height * 0.5303571,
        size.width * 0.5808333, size.height * 0.5771429);
    path_0.lineTo(size.width * 0.5808333, size.height * 0.7828571);
    path_0.lineTo(size.width * 0.3333333, size.height * 0.7842857);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
