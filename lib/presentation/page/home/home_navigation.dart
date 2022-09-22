import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suyaa_mobile/presentation/page/home/home.dart';
import 'package:suyaa_mobile/presentation/page/home/item_shop.dart';
import 'package:suyaa_mobile/presentation/page/home/settings.dart';
import 'package:suyaa_mobile/presentation/page/home/sleep_history/sleep_history_page.dart';
import 'package:suyaa_mobile/presentation/page/home/timer.dart';
import 'package:suyaa_mobile/presentation/page/home/utils/page_enum.dart';

class HomeNavigationScreen extends StatefulWidget {
  HomeNavigationScreen({
    super.key,
    required this.index,
  }) {
    print('created');
  }

  final HomePagesIndex index;

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

// TODO(atahatah): initが呼ばれないようにする
class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  late HomePagesIndex currentIndex;

  @override
  void initState() {
    print('init');
    currentIndex = widget.index;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies:${widget.index}');
    currentIndex = widget.index;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    print(currentIndex.name);
    final sleepHistoryPageKey = GlobalObjectKey<SleepHistoryPageState>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 33),
      body: SafeArea(child: () {
        switch (currentIndex) {
          case HomePagesIndex.timer:
            return const TimerScreen();
          case HomePagesIndex.home:
            return const MainPage();
          case HomePagesIndex.sleepHistory:
            return SleepHistoryPage(
              key: sleepHistoryPageKey,
            );
          case HomePagesIndex.itemShop:
            return const ItemShop();
          case HomePagesIndex.settings:
            return const SettingsScreen();
        }
      }()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 33, 33, 66),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex.index,
        items: HomePagesIndex.values
            .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.name,
                ))
            .toList(),
        onTap: (value) => context.go(HomePagesIndex.values[value].path),
      ),
    );
  }
}
