import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_font/components/sleep_history.dart';

import '../service/server.dart';

class SleepHistoryListPage extends StatefulWidget {
  const SleepHistoryListPage({Key? key}) : super(key: key);

  @override
  State<SleepHistoryListPage> createState() => _SleepHistoryListPageState();
}

class _SleepHistoryListPageState extends State<SleepHistoryListPage> {
  /// sleep_history_list.dartで使う用
  final Map<DateTime, List<DairySleepModel>> sleepCalender = {};

  /// sleep_hisotry.dartで使う用
  final Map<DateTime, Map<DateTime, SleepModel>> sleepHistory = {};

  Future fetchData(Server server) async {
    final jsonData = await server.fetchTestData();
    if (jsonData['status']) {
      for (final dayJson in jsonData['data']) {
        if (dayJson.containsKey('dateOfSleep') &&
            dayJson.containsKey('levels')) {
          final date = DateTime.parse(dayJson['dateOfSleep']);
          sleepCalender.addAll({date: <DairySleepModel>[]});
          sleepHistory.addAll({date: {}});
          for (final levelJson in dayJson['levels']) {
            if (levelJson.containsKey('score') &&
                levelJson.containsKey('start') &&
                levelJson.containsKey('duration') &&
                levelJson.containsKey('data') &&
                levelJson.containsKey('shortData')) {
              final dairySleep = DairySleepModel(
                  score: levelJson['score'],
                  start: levelJson['start'],
                  duration: levelJson['duration']);

              for (final dataJson in levelJson['data']) {
                final time = DateTime.parse(dataJson['dateTime']);
                final level = dataJson['level'];
                final seconds = dataJson['seconds'];
                final sleepModel = SleepModel(
                    levelString: level,
                    time: time,
                    seconds: seconds,
                    type: SleepType.normal);
                sleepHistory[date]!.addAll({time: sleepModel});
                dairySleep.addData(sleepModel);
              }
              for (final shortDataJson in levelJson['shortData']) {
                final time = DateTime.parse(shortDataJson['dateTime']);
                final level = shortDataJson['level'];
                final seconds = shortDataJson['seconds'];
                final sleepModel = SleepModel(
                    levelString: level,
                    time: time,
                    seconds: seconds,
                    type: SleepType.short);
                sleepHistory[date]!.addAll({time: sleepModel});
                dairySleep.addShortData(sleepModel);
              }
              sleepCalender[date]!.add(dairySleep);
            }
          }
        }
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: fetchData(context.read<Server>()),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong:${snapshot.error}');
            }
            if (snapshot.hasData && snapshot.data == true) {
              return ListView(
                children: sleepHistory.entries
                    .map((e) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SleepHistoryPage(
                                    sleepCalender[e.key] ?? []),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${e.key.month}月${e.key.day}日',
                                style: const TextStyle(fontSize: 19),
                              ),
                              Expanded(
                                child: CustomPaint(
                                  painter: SleepBarPainter(
                                      sleepHistory[e.key] ?? {}),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              );
            }
            return const Text('Loading');
          },
        ),
      ),
    );
  }
}

class SleepBarPainter extends CustomPainter {
  SleepBarPainter(this.sleeps);
  final Map<DateTime, SleepModel> sleeps;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    const height = 10.0;
    final paint = Paint();
    for (final sleepKey in sleeps.keys) {
      final sleep = sleeps[sleepKey] as SleepModel;
      final len = sleep.seconds.toDouble() / Duration.secondsPerDay * width;
      final start = sleep.time
              .difference(
                  DateTime(sleep.time.year, sleep.time.month, sleep.time.day))
              .inSeconds
              .toDouble() /
          Duration.secondsPerDay *
          width;
      final rect = Rect.fromLTWH(start, 0, len, height);
      canvas.drawRect(rect, paint..color = sleep.level.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SleepLevelBarPixel extends StatelessWidget {
  final int level;
  final double width;
  final double height;
  const SleepLevelBarPixel(this.level,
      {this.width = 5.0, this.height = 8.0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case 0:
        // ignore: sized_box_for_whitespace
        return Container(
          width: width,
          height: height,
          color: Colors.red,
        );
      case 1:
        return Container(
          width: width,
          height: height,
          color: Colors.blue,
        );
      case 2:
        return Container(
          width: width,
          height: height,
          color: Colors.blueGrey,
        );
      case 3:
        return Container(
          width: width,
          height: height,
          color: Colors.purple,
        );
    }
    // ignore: sized_box_for_whitespace
    return Container(
      width: width,
      height: height,
    );
  }
}
