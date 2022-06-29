import 'package:flutter/material.dart';
import 'package:rpg_font/components/set_timer.dart';
import 'package:rpg_font/components/sleep_history.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSleeping = false;
  bool hasData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: isSleeping ? Colors.black : Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ホーム画面'),
            Visibility(
              visible: !isSleeping,
              child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SetTimer()))),
                  child: const Text('タイマー')),
            ),
            Visibility(
              visible: !isSleeping,
              child: ElevatedButton(
                  onPressed: () => setState(() {
                        isSleeping = true;
                      }),
                  child: const Text('睡眠')),
            ),
            Visibility(
                visible: isSleeping,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isSleeping = false;
                        hasData = true;
                      });
                    },
                    child: const Text('起床'))),
          ],
        )),
      ),
      floatingActionButton: Visibility(
        visible: hasData,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const SleepHistoryPage()))),
          child: const Text('詳細'),
        ),
      ),
    );
  }
}
