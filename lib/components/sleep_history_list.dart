import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:provider/provider.dart';
import 'package:rpg_font/components/sleep_history.dart';
import 'package:rpg_font/model/domain.dart';

import '../const.dart';

class SleepHistoryListPage extends StatefulWidget {
  const SleepHistoryListPage({Key? key}) : super(key: key);

  @override
  State<SleepHistoryListPage> createState() => _SleepHistoryListPageState();
}

class _SleepHistoryListPageState extends State<SleepHistoryListPage> {
  final Map<DateTime, int> scores = {};
  final Map<DateTime, List<int>> levels = {};
  final Map<DateTime, List<SerialSleep>> dairySleep = {};

  late String domain;
  late String port;

  Future fetchData() async {
    final response = await get(Uri.parse("http://$domain:$port/testdata"));
    final jsonData = json.decode(response.body);
    if (jsonData['status']) {
      for (final scoreJson in jsonData['data']['totalScore']) {
        if (scoreJson.containsKey('dateTime') &&
            scoreJson.containsKey('score')) {
          scores[DateTime.parse(scoreJson['dateTime'])] = scoreJson['score'];
        }
      }
      for (final levelJson in jsonData['data']['levels']) {
        if (levelJson.containsKey('dateTime') &&
            levelJson.containsKey('level')) {
          final time = DateTime.parse(levelJson['dateTime']);
          final day = DateTime(time.year, time.month, time.day);
          levels[day] ??= List.filled(48, 0);
          final index = time.hour * 2 + time.minute ~/ 30;
          final level = levels[day]![index] = levelJson['level'];

          dairySleep[day] ??= [];
          final hasSleeped = ((index == 0)
              ? ((levels[day.yesterday]?[47] ?? 0) > 0)
              : ((levels[day]![index - 1]) > 0));
          if (!hasSleeped) {
            if (level > 0) {
              dairySleep[day]!.add(SerialSleep(time, [level]));
            } else {
              dairySleep[day]!.add(SerialSleep(time, []));
            }
          } else {
            if (index == 0) {
              dairySleep[day]!.add(dairySleep[day.yesterday]!.last);
              dairySleep[day.yesterday]!.removeLast();
            }
            dairySleep[day]!.last.levels.add(level);
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
    final domainModel = context.watch<Domain>();
    domain = domainModel.domain;
    port = domainModel.port;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong:${snapshot.error}');
            }
            if (snapshot.hasData && snapshot.data == true) {
              return ListView(
                children: levels.entries
                    .map((e) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SleepHistoryPage(
                                    scores[e.key], e.value, dairySleep[e.key]),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${e.key.month}???${e.key.day}???',
                                style: const TextStyle(fontSize: 25),
                              ),
                              Row(
                                children: List.generate(48, (index) {
                                  return SleepLevelBarPixel(e.value[index]);
                                }),
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

class SleepLevelBarPixel extends StatelessWidget {
  final int level;
  final width = 5.0;
  final height = 5.0;
  const SleepLevelBarPixel(this.level, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case 0:
        return Container(
          width: width,
          height: height,
        );
      case 1:
        return Container(
          width: width,
          height: height,
          color: Colors.red,
        );
      case 2:
        return Container(
          width: width,
          height: height,
          color: Colors.green,
        );
      case 3:
        return Container(
          width: width,
          height: height,
          color: Colors.blue,
        );
    }
    return Container(
      width: width,
      height: height,
    );
  }
}

extension on DateTime {
  DateTime get yesterday {
    return DateTime(year, month, day).subtract(const Duration(days: 1));
  }

  DateTime get tomorrow {
    return DateTime(year, month, day).add(const Duration(days: 1));
  }
}
