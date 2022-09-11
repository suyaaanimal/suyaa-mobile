import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/auth.dart';
import 'package:suyaa_mobile/application/controller/user.dart';
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
    final auth = context.read<Auth>();
    return Scaffold(
      body: Container(
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
                Visibility(
                  visible: !isSleeping,
                  child: ElevatedButton(
                      onPressed: () => context.push('/home/timer'),
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
                    onPressed: () => context.push('/home/itemShop'),
                  ),
                  child: ElevatedButton(
                      onPressed: () => maskModel.connect(),
                      child: const Text('Metamaskに接続')),
                ),
                ElevatedButton(
                    onPressed: () => auth.connectFitbit(),
                    child: const Text('fitbitに連携')),
                ElevatedButton(
                    onPressed: auth.deleteCashedAccessToken,
                    child: const Text('アクセストークンの削除')),
                ElevatedButton(
                  onPressed: auth.signOut,
                  child: const Text('サインアウト'),
                ),
              ],
            )),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isSleeping && hasData,
        child: FloatingActionButton(
          onPressed: () => context.push('/home/sleepHistory'),
          child: const Text('詳細'),
        ),
      ),
    );
  }
}
