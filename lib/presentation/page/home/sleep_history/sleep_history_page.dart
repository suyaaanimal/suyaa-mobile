import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/user.dart';
import 'package:suyaa_mobile/presentation/component/painter/sleep_bar.dart';

class SleepHistoryPage extends StatefulWidget {
  const SleepHistoryPage({Key? key}) : super(key: key);

  @override
  State<SleepHistoryPage> createState() => _SleepHistoryPageState();
}

class _SleepHistoryPageState extends State<SleepHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: context.read<User>().fetchSleepData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong:${snapshot.error}');
            }
            if (snapshot.hasData) {
              final user = context.read<User>();
              final sleepCalender = user.sleepCalender;
              return ListView(
                children: user.sleepDataKeys
                    .map((date) => GestureDetector(
                          onTap: () {
                            final year = date.year;
                            final month = date.month.toString().padLeft(2, '0');
                            final day = date.day.toString().padLeft(2, '0');
                            context.push('/home/sleepHistory/$year$month$day');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${date.month}月${date.day}日',
                                style: const TextStyle(fontSize: 19),
                              ),
                              Expanded(
                                  child: CustomPaint(
                                painter: SleepBarPainter(sleepCalender[date]!),
                              ))
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