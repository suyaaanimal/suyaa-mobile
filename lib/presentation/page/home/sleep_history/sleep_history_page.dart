import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/user.dart';
import 'package:suyaa_mobile/presentation/component/painter/sleep_bar.dart';
import 'package:suyaa_mobile/presentation/page/home/utils/page_enum.dart';

class SleepHistoryPage extends StatefulWidget {
  const SleepHistoryPage({Key? key}) : super(key: key);

  @override
  State<SleepHistoryPage> createState() => SleepHistoryPageState();
}

class SleepHistoryPageState extends State<SleepHistoryPage> {
  // TODO: 左右スライドの時の時間が変わらない
  TimeOfDay? draggingTime;
  bool? tossTimeToLeft;
  bool tookOff = true;
  double? draggingHeight;
  final timeTextKey = GlobalKey();
  double timeTextWidth = 20;

  /// -1.0 <= noonLocation <= 1.0
  double noonLocation = 0;

  @override
  void initState() {
    super.initState();
  }

  Size _getSize() {
    final RenderBox? renderBoxRed =
        timeTextKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBoxRed == null) return Size.zero;
    return renderBoxRed.size;
  }

  _afterLayout(_) {
    timeTextWidth = _getSize().width;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<User>().fetchSleepData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong:${snapshot.error}');
        }
        if (snapshot.hasData) {
          final user = context.read<User>();
          final sleepCalender = user.sleepCalender;
          return LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            const dateWidth = 40.0;
            final sleepBarWidth = width - dateWidth;
            return SizedBox(
              width: width,
              child: Stack(
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: (details) =>
                        _onHorizontalDragUpdate(
                            details, dateWidth, sleepBarWidth),
                    onHorizontalDragEnd: (details) =>
                        setState(() => tookOff = true),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: dateWidth),
                            SizedBox(
                              width: sleepBarWidth,
                              child: Slider(
                                  min: -0.5,
                                  max: 0.5,
                                  value: noonLocation,
                                  onChanged: (value) {
                                    setState(() {
                                      noonLocation = value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        ...user.sleepDataKeys
                            .map((date) => GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => _onTap(date),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: dateWidth,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${date.month.toString().padLeft(2)}/${date.day.toString().padLeft(2)}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                            child: CustomPaint(
                                          painter: SleepBarPainter(
                                              noonLocation, date, {
                                            ...sleepCalender[DateTime(
                                                    date.year,
                                                    date.month,
                                                    date.day - 1)] ??
                                                {},
                                            ...sleepCalender[date] ?? {},
                                            ...sleepCalender[DateTime(
                                                    date.year,
                                                    date.month,
                                                    date.day + 1)] ??
                                                {},
                                          }),
                                        ))
                                      ],
                                    ),
                                  ),
                                ))
                            .toList()
                      ],
                    ),
                  ),
                  if (draggingTime != null)
                    AnimatedPositioned(
                        top: max(0, draggingHeight! - 120.0),
                        left: timeTextWidth / 2 +
                            (tossTimeToLeft != null && tookOff == true
                                ? (tossTimeToLeft! ? -10 : width + 10)
                                : (draggingTime!.hour * 60.0 +
                                        draggingTime!.minute) /
                                    (TimeOfDay.minutesPerHour *
                                        TimeOfDay.hoursPerDay) *
                                    sleepBarWidth),
                        height: constraints.maxHeight,
                        duration: const Duration(milliseconds: 300),
                        onEnd: () => _onAnimationEnd(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              draggingTime!.format(context),
                              key: timeTextKey,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                  width: 1, height: 100, color: Colors.white),
                            ),
                          ],
                        ))
                ],
              ),
            );
          });
        }
        return const Text('Loading');
      },
    );
  }

  void _onTap(DateTime date) {
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    context.push('/home/${HomePagesIndex.sleepHistory.name}/$year$month$day');
  }

  void _onHorizontalDragUpdate(details, dateWidth, sleepBarWidth) {
    setState(() => tookOff = false);
    final horizontalRate =
        (details.localPosition.dx - dateWidth) / sleepBarWidth;
    if (!(0 < horizontalRate && horizontalRate < 1.0)) return;
    if (details.delta.dx > 10) {
      tossTimeToLeft = false;
    } else if (details.delta.dx < -10) {
      tossTimeToLeft = true;
    }
    final currentMin =
        TimeOfDay.minutesPerHour * TimeOfDay.hoursPerDay * horizontalRate;
    setState(() {
      draggingTime =
          TimeOfDay(hour: currentMin ~/ 60, minute: currentMin.toInt() % 60);
      draggingHeight = details.localPosition.dy;
    });
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _onAnimationEnd() {
    if (tossTimeToLeft == null) return;
    setState(() {
      draggingTime = null;
      draggingHeight = null;
      tossTimeToLeft = null;
    });
  }
}
