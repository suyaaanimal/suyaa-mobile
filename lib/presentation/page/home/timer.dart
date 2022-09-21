import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('タイマー'),
        ElevatedButton(
            onPressed: () => context.pop(), child: const Text('タイマーセット'))
      ],
    ));
  }
}
