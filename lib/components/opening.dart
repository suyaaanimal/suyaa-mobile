import 'package:flutter/material.dart';
import 'package:rpg_font/components/login.dart';
import 'package:rpg_font/components/speech_buddle.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  final texts = [
    'こんにちは、世界！こんにちは、世界！こんにちは、世界！こんにちは、世界！',
    'さあ冒険の始まりだ！さあ冒険の始まりだ！さあ冒険の始まりだ！さあ冒険の始まりだ！'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomFloattingSpeechBubble(
        texts: texts,
        onEnd: () => Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const LoginPage()))),
        child: const Center(
          child: Text('映像が流れる...'),
        ),
      ),
    );
  }
}
