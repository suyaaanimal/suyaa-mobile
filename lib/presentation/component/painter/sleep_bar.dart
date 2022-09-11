import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_model.dart';
import 'package:suyaa_mobile/infrastructure/enum/sleep_depth.dart';

class SleepBarPainter extends CustomPainter {
  SleepBarPainter(this.sleeps);
  final Map<DateTime, SleepModel> sleeps;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    const height = 10.0;
    final paint = Paint();
    for (final sleepKey in sleeps.keys) {
      final sleep = sleeps[sleepKey] as SleepModel;
      final len = sleep.seconds.toDouble() / Duration.secondsPerDay * width;
      final start = sleep.time
              .difference(
                  DateTime(sleep.time.year, sleep.time.month, sleep.time.day))
              .inSeconds
              .toDouble() /
          Duration.secondsPerDay *
          width;
      final rect = Rect.fromLTWH(start, 0, len, height);
      canvas.drawRect(rect, paint..color = sleep.level.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
