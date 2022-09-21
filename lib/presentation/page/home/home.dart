import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/infrastructure/service/metamask/metamask.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSleeping = false;
  bool hasData = true;

  @override
  Widget build(BuildContext context) {
    final maskModel = context.watch<Metamask>();
    return Container(
      color: isSleeping ? Colors.black : Colors.white,
      child: Stack(
        children: [
          Positioned(
              child: Visibility(
            visible: isSleeping,
            replacement: Visibility(
              visible: !maskModel.itemBuyed,
              replacement: Image.asset('asset/seichou/otona_big.png'),
              child: Image.asset('asset/seichou/otona.png'),
            ),
            child: Image.asset('asset/zzz.png'),
          )),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (maskModel.signined)
                FutureBuilder(
                    future: maskModel.balance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('データの取得に失敗しました');
                      }
                      if (snapshot.hasData) {
                        return Text('残高:${snapshot.data}');
                      }
                      return const Text('残高の取得中...');
                    }),
            ],
          )),
        ],
      ),
    );
  }
}
