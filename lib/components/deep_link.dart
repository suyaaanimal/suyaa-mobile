import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FitbitAuthCallback extends StatefulWidget {
  const FitbitAuthCallback({Key? key}) : super(key: key);

  @override
  State<FitbitAuthCallback> createState() => _FitbitAuthCallbackState();
}

class _FitbitAuthCallbackState extends State<FitbitAuthCallback> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('redirected by deep link'),
      ),
    );
  }
}
