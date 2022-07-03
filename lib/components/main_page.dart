import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_font/components/item_shop.dart';
import 'package:rpg_font/components/set_timer.dart';
import 'package:rpg_font/components/sleep_history_list.dart';

import '../model/metamask.dart';

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
    final maskModel = context.watch<Metamask>();
    return Scaffold(
      body: Container(
        color: isSleeping ? Colors.black : Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ホーム画面'),
            Visibility(
                visible: maskModel.signined,
                child: FutureBuilder(
                    future: maskModel.balance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('データの取得に失敗しました');
                      }
                      if (snapshot.hasData) {
                        return Text('残高:${snapshot.data}');
                      }
                      return const Text('残高の取得中...');
                    })),
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
            Visibility(
              visible: !maskModel.signined,
              replacement: ElevatedButton(
                child: const Text('Item Shop'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ItemShop(),
                  ),
                ),
              ),
              child: ElevatedButton(
                  onPressed: () => maskModel.connect(),
                  child: const Text('Metamaskに接続')),
            ),
          ],
        )),
      ),
      floatingActionButton: Visibility(
        visible: !isSleeping && hasData,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const SleepHistoryListPage()))),
          child: const Text('詳細'),
        ),
      ),
    );
  }
}
