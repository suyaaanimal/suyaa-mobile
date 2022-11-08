import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/monster.dart';
import 'package:suyaa_mobile/infrastructure/enum/monster_genesis.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final monster = context.read<Monster>();
    return FutureBuilder<MonsterGenesis>(
      future: monster.fetchGenesis(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('fitbitの連携をしてください。'),
          );
        }
        if (snapshot.hasData) {
          final monsterGenesis = snapshot.data!;
          return Center(
            child: Image.asset(monsterGenesis.assetPath),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
