import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_model.dart';
import 'package:suyaa_mobile/infrastructure/enum/sleep_depth.dart';

class SleepBarPainter extends CustomPainter {
  SleepBarPainter(this.noonLocation, this.date, this.sleeps);
  final Map<DateTime, SleepModel> sleeps;
  final double noonLocation;
  final DateTime date;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    const height = 10.0;
    final paint = Paint();
    for (final sleepKey in sleeps.keys) {
      final _WhichDay whichDay = _WhichDay.fromDate(sleepKey, date);

      if (noonLocation <= 0 && whichDay == _WhichDay.yesterday) {
        continue;
      } else if (noonLocation >= 0 && whichDay == _WhichDay.tomorrow) {
        continue;
      }

      final sleep = sleeps[sleepKey] as SleepModel;
      double len = sleep.seconds.toDouble() / Duration.secondsPerDay * width;
      final start = sleep.time
              .difference(
                  DateTime(sleep.time.year, sleep.time.month, sleep.time.day))
              .inSeconds
              .toDouble() /
          Duration.secondsPerDay *
          width;
      double left = start + (noonLocation + whichDay.noon) * width;
      if (left < 0 && left + len > 0) {
        len += left;
        left = 0;
      }
      if (left < 0 || left >= width) continue;
      final rect = Rect.fromLTWH(left, 0, len, height);
      canvas.drawRect(rect, paint..color = sleep.level.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

enum _WhichDay {
  yesterday(-1),
  today(0),
  tomorrow(1),
  ;

  final int noon;
  const _WhichDay(this.noon);

  static _WhichDay fromDate(DateTime sleepKey, DateTime date) {
    if (sleepKey.year == date.year &&
        sleepKey.month == date.month &&
        sleepKey.day == date.day) {
      return _WhichDay.today;
    } else if (sleepKey.isBefore(date)) {
      return _WhichDay.yesterday;
    } else if (sleepKey.isAfter(date)) {
      return _WhichDay.tomorrow;
    } else {
      throw Exception('the sleep data has too much.');
    }
  }
}
