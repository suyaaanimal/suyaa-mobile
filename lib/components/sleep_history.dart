import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepHistoryPage extends StatefulWidget {
  final int? score;
  final List<int> levels;
  const SleepHistoryPage(this.score, this.levels, {Key? key}) : super(key: key);

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
        child: Column(children: [
          const Text('睡眠履歴'),
          Text(
              '睡眠点数:${widget.score != null ? '${widget.score}点' : '取得に失敗しました'}'),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            series: <ChartSeries>[
              StepLineSeries<ChartData, String>(
                  dataSource: const [],
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
