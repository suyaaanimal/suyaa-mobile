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
                  LayoutBuilder(builder: (context, constarints) {
                    return SizedBox(
                      width: constarints.maxWidth * 0.9,
                      child: Card(
                        color: Colors.black,
                        margin: const EdgeInsets.all(10),
                        elevation: 8,
                        shadowColor: Colors.purpleAccent.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: Column(
                            children: [
                              LayoutBuilder(
                                builder: ((context, constraints) {
                                  double graphWidth =
                                      constraints.maxWidth * 0.8;
                                  double maxGraphWidth =
                                      sleep.levels.length * 20.0;
                                  if (maxGraphWidth < graphWidth) {
                                    graphWidth = maxGraphWidth;
                                  }
                                  double blockWidth =
                                      graphWidth / sleep.dataSource.length;
                                  double blockHeight = blockWidth * 0.6;
                                  double graphHeight = blockHeight * 4;
                                  return CustomPaint(
                                    size: Size(graphWidth, graphHeight),
                                    painter: MyPainter(
                                      sleep.dataSource
                                          .map((e) => e.level)
                                          .toList(),
                                      [
                                        Colors.red,
                                        Colors.blue,
                                        Colors.blueGrey,
                                        Colors.purple,
                                      ],
                                      0.6,
                                      sleep.dataSource.first.time,
                                      sleep.dataSource.last.time,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
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

class MyPainter extends CustomPainter {
  MyPainter(this.data, this.colors, this.blockRatio, this.start, this.end);
  final List<int> data;
  List<Color> colors;
  final double blockRatio;
  final DateTime start;
  final DateTime end;

  @override
  void paint(Canvas canvas, Size size) {
    double blockWidth = size.width / data.length;
    double blockHeight = blockWidth * blockRatio;
    final paint = List.generate(4, (index) => Paint()..color = colors[index]);
    for (var i = 0; i < data.length; i++) {
      final rect = Rect.fromLTWH(
          blockWidth * i, data[i] * blockHeight, blockWidth, blockHeight);
      canvas.drawRect(rect, paint[data[i]]);
    }

    // 時刻
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 10,
    );

    final startText =
        '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    final endText =
        '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
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
    )..layout(minWidth: blockWidth, maxWidth: size.width / 2);

    var startTextOffset = Offset(0, blockHeight * 4 + 5.0);
    var endTextOffset = Offset(size.width - blockWidth, blockHeight * 4 + 5.0);
    startTextPainter.paint(canvas, startTextOffset);
    endTextPainter.paint(canvas, endTextOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
