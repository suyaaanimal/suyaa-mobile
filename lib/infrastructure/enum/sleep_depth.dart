import 'package:flutter/material.dart';

enum SleepLevel {
  // 4つバージョン
  wake,
  light,
  deep,
  rem,
  // 3つバージョン
  awake,
  asleep,
  restless,
}

extension SleepExtension on SleepLevel {
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
      case SleepLevel.awake:
        return Colors.orange;
      case SleepLevel.asleep:
        return Colors.green;
      case SleepLevel.restless:
        return Colors.grey;
    }
  }

  int get depth {
    switch (this) {
      case SleepLevel.wake:
        return 0;
      case SleepLevel.light:
        return 1;
      case SleepLevel.deep:
        return 2;
      case SleepLevel.rem:
        return 3;
      case SleepLevel.awake:
        return 0;
      case SleepLevel.asleep:
        return 1;
      case SleepLevel.restless:
        return 2;
    }
  }
}
