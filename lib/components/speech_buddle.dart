import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
