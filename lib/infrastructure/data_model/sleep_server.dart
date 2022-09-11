import 'package:flutter/material.dart';

@immutable
class SleepServerModel {
  const SleepServerModel._({required this.dateOfSleep, required this.levels});
  SleepServerModel.fromJson(Map<String, dynamic> json)
      : this._(
          dateOfSleep: DateTime.parse(json['dateOfSleep']),
          levels: SleepServerLevelsModel.fromJson(json['levels']),
        );
  final DateTime dateOfSleep;
  final SleepServerLevelsModel levels;
}

@immutable
class SleepServerLevelsModel {
  const SleepServerLevelsModel._(
      {required this.start,
      required this.score,
      required this.duration,
      required this.isMainSleep,
      required this.data});
  SleepServerLevelsModel.fromJson(Map<String, dynamic> json)
      : this._(
          start: DateTime.parse(json['start']),
          score: json['score'],
          duration: int.parse(json['duration']),
          isMainSleep: json['isMainSleep'],
          data: (json['data'] as List<Map<String, dynamic>>)
              .map((e) => SleepServerDataModel.fromJson(e))
              .toList(),
        );
  final DateTime start;
  final int score;
  final int duration;
  final bool isMainSleep;
  final List<SleepServerDataModel> data;
}

@immutable
class SleepServerDataModel {
  const SleepServerDataModel._(
      {required this.dateTime, required this.level, required this.seconds});
  SleepServerDataModel.fromJson(Map<String, dynamic> json)
      : this._(
          dateTime: DateTime.parse(json['dateTime']),
          level: json['level'],
          seconds: json['seconds'],
        );
  final DateTime dateTime;
  final String level;
  final int seconds;
}
