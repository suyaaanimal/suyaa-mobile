import 'dart:math';

import 'package:flutter/material.dart';

class SleepHistoryPage extends StatefulWidget {
  final List<DairySleepModel> dairySleeps;
  const SleepHistoryPage(this.dairySleeps, {Key? key}) : super(key: key);

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
            for (final sleep in widget.dairySleeps)
              Column(
                children: [
                  Text('睡眠点数: ${sleep.score}点'),
                  LayoutBuilder(builder: (context, constrants) {
                    return SizedBox(
                      width: constrants.maxWidth * 0.9,
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
                              LayoutBuilder(builder: ((context, constraints) {
                                double graphWidth = constraints.maxWidth * 0.8;
                                double graphHeight = graphWidth * 0.6;
                                return CustomPaint(
                                    size: Size(graphWidth, graphHeight),
                                    painter: MyPainter(sleep));
                              }))
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ],
              )
          ]),
        ),
      ),
    );
  }
}

enum SleepLevel {
  wake,
  light,
  deep,
  rem,
}

extension SleepColor on SleepLevel {
  Color get color {
    switch (this) {
      case SleepLevel.wake:
        return Colors.red;
      case SleepLevel.light:
        return Colors.blue;
      case SleepLevel.deep:
        return Colors.blueGrey;
      case SleepLevel.rem:
        return Colors.purple;
    }
  }
}

enum SleepType {
  normal,
  short,
}

class SleepModel {
  SleepModel(
      {required this.time,
      required levelString,
      required this.seconds,
      required this.type})
      : level = SleepLevel.values
            .firstWhere((element) => element.name == levelString);
  final DateTime time;
  final SleepLevel level;
  final int seconds;
  final SleepType type;
}

class DairySleepModel {
  DairySleepModel(
      {required this.score, required String start, required this.duration})
      : get2sleep = DateTime.parse(start);

  final int score;
  final int duration;
  final DateTime get2sleep;

  final data = <DateTime, SleepModel>{};
  final shortData = <DateTime, SleepModel>{};

  DateTime get awake => get2sleep.add(Duration(milliseconds: duration));
  Map<DateTime, SleepModel> get allData => {...data, ...shortData};

  void addData(SleepModel s) => data.addAll({s.time: s});
  void addShortData(SleepModel s) => shortData.addAll({s.time: s});
}

class MyPainter extends CustomPainter {
  MyPainter(this.dairySleep);
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
          sleep.level.index * blockHeight, blockWidth, blockHeight);
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
