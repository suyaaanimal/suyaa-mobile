import 'package:flutter/material.dart';
import 'package:suyaa_mobile/presentation/component/painter/sleep_noon_slider.dart';

class SleepNoonSlider extends StatelessWidget {
  SleepNoonSlider({super.key, required this.value, required this.onChanged});
  final min = -1.0;
  final max = 1.0;
  double value;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    if (value < min) {
      value = min;
    } else if (value > max) {
      value = max;
    }
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth - 16;
      return SizedBox(
        width: width,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              var value =
                  (details.localPosition.dx / width) * (max - min) + min;
              if (value < min) {
                value = min;
              } else if (value > max) {
                value = max;
              }
              onChanged?.call(value);
            },
            onTapDown: ((details) {
              var value =
                  (details.localPosition.dx / width) * (max - min) + min;
              if (value < min) {
                value = min;
              } else if (value > max) {
                value = max;
              }
              onChanged?.call(value);
            }),
            child: CustomPaint(painter: SleepNoonSliderPainter(value)),
          ),
        ),
      );
    });
  }
}
