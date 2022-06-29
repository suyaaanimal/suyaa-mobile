import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepHistoryPage extends StatefulWidget {
  const SleepHistoryPage({Key? key}) : super(key: key);

  @override
  State<SleepHistoryPage> createState() => _SleepHistoryPageState();
}

class _SleepHistoryPageState extends State<SleepHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final jsonData = {
      'totalScore': 10, // efficiency
      'levels': [
        {'dateTime': DateTime(2022, 6, 29, 23, 0), 'level': 0}, // level: wake
        {'dateTime': DateTime(2022, 6, 29, 23, 30), 'level': 1}, //level: rem
        {'dateTime': DateTime(2022, 6, 30, 1, 0), 'level': 1},
        {'dateTime': DateTime(2022, 6, 30, 1, 30), 'level': 1},
        {'dateTime': DateTime(2022, 6, 30, 2, 0), 'level': 2}, // level: light
        {'dateTime': DateTime(2022, 6, 30, 2, 30), 'level': 2},
        {'dateTime': DateTime(2022, 6, 30, 3, 0), 'level': 2},
        {'dateTime': DateTime(2022, 6, 30, 3, 30), 'level': 3}, // level: deep
        {'dateTime': DateTime(2022, 6, 30, 4, 0), 'level': 2},
        {'dateTime': DateTime(2022, 6, 30, 4, 30), 'level': 1},
        {'dateTime': DateTime(2022, 6, 30, 5, 0), 'level': 2},
        {'dateTime': DateTime(2022, 6, 30, 5, 30), 'level': 3},
        {'dateTime': DateTime(2022, 6, 30, 6, 0), 'level': 2},
        {'dateTime': DateTime(2022, 6, 30, 6, 30), 'level': 2},
        {'dateTime': DateTime(2022, 6, 30, 7, 0), 'level': 1},
        {'dateTime': DateTime(2022, 6, 30, 7, 30), 'level': 0},
      ]
    };
    final totalScore = jsonData['totalScore'];
    final sleepLevels = (jsonData['levels'] as List?)
            ?.map((e) => ChartData(e['dateTime'], e['level']))
            .toList() ??
        [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep History'),
      ),
      body: Center(
        child: Column(children: [
          const Text('睡眠履歴'),
          Text('睡眠点数:$totalScore点'),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            series: <ChartSeries>[
              StepLineSeries<ChartData, String>(
                  dataSource: sleepLevels,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y)
            ],
          ),
        ]),
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.level);
  final DateTime time;
  String get x => '${time.hour}:${time.minute}';
  final int level;
  double get y => level.toDouble();
}
