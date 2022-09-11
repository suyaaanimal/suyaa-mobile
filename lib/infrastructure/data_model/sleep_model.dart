import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_server.dart';
import 'package:suyaa_mobile/infrastructure/enum/sleep_depth.dart';

@immutable
class SleepModel {
  SleepModel({
    required this.time,
    required levelString,
    required this.seconds,
  }) : level = SleepLevel.values
            .firstWhere((element) => element.name == levelString);
  SleepModel.fromServer(SleepServerDataModel s)
      : time = s.dateTime,
        seconds = s.seconds,
        level =
            SleepLevel.values.firstWhere((element) => element.name == s.level);
  final DateTime time;
  final SleepLevel level;
  final int seconds;
}
