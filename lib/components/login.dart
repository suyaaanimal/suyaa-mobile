import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rpg_font/components/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('DEMO画面が表示される...'),
        ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const MainPage()))),
            child: const Text('START'))
      ])),
    );
  }
}
