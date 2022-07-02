import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_font/components/main_page.dart';

import '../model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signuped = false;
  bool loading = false;
  bool failed = false;
  bool success = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final walletAddressController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    walletAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<User>();
    return Scaffold(
      body: Visibility(
        visible: !loading,
        replacement: const CircularProgressIndicator(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('DEMO画面が表示される...'),
          Visibility(visible: failed, child: const Text('失敗しました。')),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'username'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'password'),
          ),
          Visibility(
            visible: !signuped,
            child: TextField(
              controller: walletAddressController,
              decoration: const InputDecoration(labelText: 'wallet address'),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                if (signuped) {
                  success = await userModel.signin(
                      usernameController.text, passwordController.text);
                } else {
                  success = await userModel.signup(usernameController.text,
                      passwordController.text, walletAddressController.text);
                }
                setState(() {
                  loading = false;
                });
                if (success) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const MainPage())));
                } else {
                  setState(() {
                    failed = true;
                  });
                }
              },
              child: const Text('START')),
          ElevatedButton(
            onPressed: () => setState(() {
              signuped = !signuped;
            }),
            child: Text(signuped ? '新規登録へ' : 'ログインへ'),
          )
        ]),
      ),
    );
  }
}
