import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/infrastructure/service/metamask/metamask.dart';

class ItemShop extends StatefulWidget {
  const ItemShop({Key? key}) : super(key: key);

  @override
  State<ItemShop> createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  @override
  Widget build(BuildContext context) {
    final maskModel = context.watch<Metamask>();
    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('asset/shop.png'),
            Image.asset('asset/introduction/Bottom1-2.png'),
          ],
        ),
      ),
      Center(
        child: Visibility(
          visible: maskModel.signined,
          replacement: const Text('Metamaskなどにログインしてください'),
          child: Column(children: [
            const SizedBox(height: 380),
            const Text(
              "\$1",
              style: TextStyle(fontSize: 35),
            ),
            ElevatedButton(
                onPressed: () async {
                  await maskModel.burn(1);
                  await showDialog<void>(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('購入ありがとうございます！'),
                          actions: <Widget>[
                            GestureDetector(
                              child: const Text('OK'),
                              onTap: () => context.pop(),
                            ),
                          ],
                        );
                      });
                  maskModel.buyItem();
                },
                child: const Text("買う")),
          ]),
        ),
      ),
    ]);
  }
}
