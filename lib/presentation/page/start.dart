import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suyaa_mobile/presentation/page/home/utils/page_enum.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Start Page'),
                ElevatedButton(
                    onPressed: () => context.push(HomePagesIndex.home.path),
                    child: const Text('Start'))
              ]),
        ),
      ),
    );
  }
}
