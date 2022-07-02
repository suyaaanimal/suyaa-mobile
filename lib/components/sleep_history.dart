import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepHistoryPage extends StatefulWidget {
  final int? score;
  final List<int> levels;
  final List<SerialSleep>? dairySleeps;
  const SleepHistoryPage(this.score, this.levels, this.dairySleeps, {Key? key})
      : super(key: key);

  @override
  State<SleepHistoryPage> createState() => _SleepHistoryPageState();
}

class _SleepHistoryPageState extends State<SleepHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep History'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            const Text('睡眠履歴'),
            Text(
                '睡眠点数:${widget.score != null ? '${widget.score}点' : '取得に失敗しました'}'),
            if (widget.dairySleeps != null)
              for (final sleep in widget.dairySleeps!)
                if (sleep.levels.isNotEmpty)
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                      StepLineSeries<ChartData, String>(
                          dataSource: sleep.dataSource,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ],
                  ),
          ]),
        ),
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

class SerialSleep {
  SerialSleep(this.start, this.levels);
  final DateTime start;
  final List<int> levels;
  List<ChartData> get dataSource => List.generate(
      levels.length,
      (index) =>
          ChartData(start.add(Duration(minutes: index * 30)), levels[index]));
}
