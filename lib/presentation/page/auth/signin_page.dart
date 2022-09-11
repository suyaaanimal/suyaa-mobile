import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signuped = true;
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
    final auth = context.watch<Auth>();
    bool failed = auth.failed;
    String failedReason = auth.failedReason;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('asset/Gametytle.png'),
        Visibility(visible: failed, child: Text(failedReason)),
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
        Visibility(
          visible: signuped,
          replacement: ElevatedButton(
              onPressed: () => auth.signUp(usernameController.text,
                  passwordController.text, walletAddressController.text),
              child: const Text('登録')),
          child: ElevatedButton(
              onPressed: () =>
                  auth.signIn(usernameController.text, passwordController.text),
              child: const Text('START')),
        ),
        ElevatedButton(
          onPressed: () => setState(() {
            signuped = !signuped;
          }),
          child: Text(signuped ? '新規登録へ' : 'ログインへ'),
        )
      ]),
    );
  }
}
