import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/user.dart';
import 'package:suyaa_mobile/presentation/component/painter/sleep_graph.dart';

class DailySleep extends StatefulWidget {
  DailySleep({Key? key, required this.sid}) : super(key: key) {
    year = int.parse(sid.substring(0, 4));
    month = int.parse(sid.substring(4, 6));
    day = int.parse(sid.substring(6));
  }

  late final int year;
  late final int month;
  late final int day;

  final String sid;
  @override
  State<DailySleep> createState() => _DailySleepState();
}

class _DailySleepState extends State<DailySleep> {
  @override
  Widget build(BuildContext context) {
    final dairySleeps = context
        .watch<User>()
        .dairySleep[DateTime(widget.year, widget.month, widget.day)];
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.year}/${widget.month}/${widget.day}'),
      ),
      body: dairySleeps == null
          ? const Center(
              child: Text('No Data'),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(children: [
                  const Text('睡眠履歴'),
                  for (final sleep in dairySleeps)
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
                                    LayoutBuilder(
                                        builder: ((context, constraints) {
                                      double graphWidth =
                                          constraints.maxWidth * 0.8;
                                      double graphHeight = graphWidth * 0.6;
                                      return CustomPaint(
                                          size: Size(graphWidth, graphHeight),
                                          painter: SleepGraphPainter(sleep));
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
