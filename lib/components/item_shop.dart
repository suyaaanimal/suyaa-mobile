import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/metamask.dart';

class ItemShop extends StatefulWidget {
  const ItemShop({Key? key}) : super(key: key);

  @override
  State<ItemShop> createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  @override
  Widget build(BuildContext context) {
    final maskModel = context.watch<Metamask>();
    return Scaffold(
      body: Visibility(
        visible: maskModel.signined,
        replacement: const Text('Metamaskなどにログインしてください'),
        child: Column(children: [
          const Text("itemの画像"),
          const Text("\$1"),
          ElevatedButton(
              onPressed: () => maskModel.burn(1), child: const Text("買う")),
        ]),
      ),
    );
  }
}
