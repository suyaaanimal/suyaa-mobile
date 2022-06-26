import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final texts = [
    'こんにちは、世界！こんにちは、世界！こんにちは、世界！こんにちは、世界！',
    'hello, world! hello, world! hello, world! hello, world! hello, world!',
    'さあ冒険の始まりだ！さあ冒険の始まりだ！さあ冒険の始まりだ！さあ冒険の始まりだ！'
  ];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // controller.sink.add(controller.stream.value + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BottomFloattingSpeechBubble(
        texts: texts,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BottomFloattingSpeechBubble extends StatelessWidget {
  const BottomFloattingSpeechBubble({
    required this.child,
    required this.texts,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      child,
      Positioned(
        left: 20.0,
        bottom: 20.0,
        child: SpeechBubble(
          texts,
          width: screenWidth - 40.0,
        ),
      ),
    ]);
  }
}

class SpeechBubble extends StatefulWidget {
  const SpeechBubble(this.texts, {required this.width, Key? key})
      : super(key: key);

  final List<String> texts;
  final double width;

  @override
  State<SpeechBubble> createState() => _SpeechBubbleState();
}

class _SpeechBubbleState extends State<SpeechBubble> {
  int textIndex = 0;
  int stringIndex = 0;
  late String viewString = widget.texts.first;
  Timer? timer;

  void resetTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (stringIndex < widget.texts[textIndex].length - 1) {
        stringIndex++;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (textIndex < widget.texts.length - 1) {
          resetTimer();
          textIndex++;
          viewString = widget.texts[textIndex];
          stringIndex = viewString.isEmpty ? 0 : 1;
          setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: Colors.black),
        child: Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(10.0),
          height: 68.0,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Text(widget.texts[textIndex].substring(0, stringIndex),
              style: GoogleFonts.getFont('DotGothic16')
                  .copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
