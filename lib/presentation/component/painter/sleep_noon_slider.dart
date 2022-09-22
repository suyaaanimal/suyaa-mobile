import 'dart:math' as math;
import 'package:flutter/material.dart';

class SleepNoonSliderPainter extends CustomPainter {
  SleepNoonSliderPainter(this.value);

  final min = -1.0;
  final max = 1.0;

  /// min <= value <= max
  final double value;

  final double r = 4;
  final double largeR = 14;

  @override
  void paint(Canvas canvas, Size size) {
    final l = size.width - 2 * largeR;
    final paint = Paint();
    if (value > 0) {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          largeR - r,
          largeR - r,
          value * l + largeR,
          largeR + r,
          topLeft: Radius.circular(r),
          bottomLeft: Radius.circular(r),
        ),
        paint..color = const Color(0xffad0000),
      );
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          value * l + largeR,
          largeR - r,
          l + 2 * largeR - r,
          largeR + r,
          topRight: Radius.circular(r),
          bottomRight: Radius.circular(r),
        ),
        paint..color = const Color(0xff0010c4),
      );
    } else if (value.abs() < 0.000001) {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          largeR - r,
          largeR - r,
          l + 2 * largeR - r,
          largeR + r,
          topRight: Radius.circular(r),
          topLeft: Radius.circular(r),
          bottomRight: Radius.circular(r),
          bottomLeft: Radius.circular(r),
        ),
        paint..color = const Color(0xff0010c4),
      );
    } else {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          largeR - r,
          largeR - r,
          (1 + value) * l + largeR,
          largeR + r,
          topLeft: Radius.circular(r),
          bottomLeft: Radius.circular(r),
        ),
        paint..color = const Color(0xff0010c4),
      );
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          (1 + value) * l + largeR,
          largeR - r,
          l + 2 * largeR - r,
          largeR + r,
          topRight: Radius.circular(r),
          bottomRight: Radius.circular(r),
        ),
        paint..color = const Color(0xff1a7200),
      );
    }
    canvas.drawCircle(
      Offset(largeR - r + l * ((value + 1) / 2), largeR),
      largeR,
      paint..color = const Color(0xff8100f2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
