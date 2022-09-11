import 'package:suyaa_mobile/infrastructure/data_model/sleep_model.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_server.dart';

class DairySleepModel {
  DairySleepModel({
    required this.score,
    required String start,
    required this.duration,
    required this.isMainSleep,
  }) : get2sleep = DateTime.parse(start);

  DairySleepModel.fromServer(SleepServerModel s)
      : duration = s.levels.duration,
        score = s.levels.score,
        get2sleep = s.levels.start,
        data = {
          for (final d in s.levels.data) d.dateTime: SleepModel.fromServer(d)
        },
        isMainSleep = s.levels.isMainSleep;

  final int score;
  final int duration;
  final DateTime get2sleep;
  final bool isMainSleep;

  var data = <DateTime, SleepModel>{};
  var shortData = <DateTime, SleepModel>{};

  DateTime get awake => get2sleep.add(Duration(milliseconds: duration));
  Map<DateTime, SleepModel> get allData => {...data, ...shortData};

  void addData(SleepModel s) => data.addAll({s.time: s});
  void addShortData(SleepModel s) => shortData.addAll({s.time: s});
}
