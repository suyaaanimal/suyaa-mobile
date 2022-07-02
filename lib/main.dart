import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/opening.dart';
import 'model/user.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider<User>(create: (_) => User())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OpeningPage(title: 'Flutter Demo Home Page'),
    );
  }
}
