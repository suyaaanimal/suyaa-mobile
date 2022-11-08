import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/auth.dart';
import 'package:suyaa_mobile/infrastructure/service/metamask/metamask.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maskModel = context.watch<Metamask>();
    final auth = context.read<Auth>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ElevatedButton(
          //     onPressed: () => maskModel.connect(),
          //     child: const Text('Metamaskに接続')),
          ElevatedButton(
              onPressed: () => auth.connectFitbit(),
              child: const Text('fitbitに連携')),
          // ElevatedButton(
          //     onPressed: auth.deleteCashedAccessToken,
          //     child: const Text('アクセストークンの削除')),
          ElevatedButton(
            onPressed: auth.signOut,
            child: const Text('サインアウト'),
          ),
        ],
      ),
    );
  }
}
