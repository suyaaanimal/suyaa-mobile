import 'dart:math';

import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/data_model/dairy_sleep.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_model.dart';
import 'package:suyaa_mobile/infrastructure/enum/sleep_depth.dart';

class SleepGraphPainter extends CustomPainter {
  SleepGraphPainter(this.dairySleep);
  final DairySleepModel dairySleep;
  late final maxSleepSeconds =
      max(const Duration(hours: 10).inSeconds, dairySleep.duration / 1000);

  @override
  void paint(Canvas canvas, Size size) {
    /// 中央揃えのための横幅
    double offsetWidth = (size.width -
            dairySleep.duration.toDouble() /
                1000.0 /
                maxSleepSeconds.toDouble() *
                size.width) /
        2;

    double blockHeight = size.height / 4;
    final paint = Paint();
    for (final sleepKey in dairySleep.allData.keys) {
      final sleep = dairySleep.allData[sleepKey] as SleepModel;
      double blockWidth =
          size.width * sleep.seconds.toDouble() / maxSleepSeconds;
      double start =
          sleep.time.difference(dairySleep.get2sleep).inSeconds.toDouble() /
              maxSleepSeconds *
              size.width;
      final rect = Rect.fromLTWH(offsetWidth + start,
          sleep.level.depth * blockHeight, blockWidth, blockHeight);
      canvas.drawRect(rect, paint..color = sleep.level.color);
    }

    // 時刻
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 10,
    );

    final startText =
        '${dairySleep.get2sleep.hour.toString().padLeft(2, '0')}:${dairySleep.get2sleep.minute.toString().padLeft(2, '0')}';
    final endText =
        '${dairySleep.awake.hour.toString().padLeft(2, '0')}:${dairySleep.awake.minute.toString().padLeft(2, '0')}';
    final startTextSpan = TextSpan(
      style: textStyle,
      text: startText,
    );
    final endTextSpan = TextSpan(
      style: textStyle,
      text: endText,
    );

    final startTextPainter = TextPainter(
      text: startTextSpan,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width / 2);
    final endTextPainter = TextPainter(
      text: endTextSpan,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width / 2);

    var startTextOffset = Offset(offsetWidth, blockHeight * 4 + 5.0);
    var endTextOffset = Offset(
        size.width * dairySleep.duration / 1000 / maxSleepSeconds + offsetWidth,
        blockHeight * 4 + 5.0);
    startTextPainter.paint(canvas, startTextOffset);
    endTextPainter.paint(canvas, endTextOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
