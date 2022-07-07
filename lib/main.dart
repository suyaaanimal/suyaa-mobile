import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_font/model/domain.dart';
import 'package:rpg_font/model/metamask.dart';
import 'components/opening.dart';
import 'model/user.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider<Domain>(create: (_) => Domain()),
    ChangeNotifierProxyProvider<Domain, User>(
      create: (context) => User(
        context.read<Domain>().domain,
        context.read<Domain>().port,
      ),
      update: (context, domain, user) =>
          (user?..updateDomain(domain.domain, domain.port)) ??
          User(domain.domain, domain.port),
    ),
    ChangeNotifierProvider<Metamask>(create: (_) => Metamask()),
  ], child: const MyApp()));
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
      home: const InputDomainPage(),
    );
  }
}

class InputDomainPage extends StatefulWidget {
  const InputDomainPage({Key? key}) : super(key: key);

  @override
  State<InputDomainPage> createState() => _InputDomainPageState();
}

class _InputDomainPageState extends State<InputDomainPage> {
  final domainTc = TextEditingController();
  final portTc = TextEditingController()..text = "3000";

  @override
  void dispose() {
    domainTc.dispose();
    portTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('サーバのIPアドレスかドメインとポート番号を入力してください。'),
            TextField(
              controller: domainTc,
              decoration: const InputDecoration(
                hintText: '192.168.10.2',
              ),
            ),
            TextField(
              controller: portTc,
              decoration: const InputDecoration(
                hintText: '3000',
              ),
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                context.read<Domain>()
                  ..domain = domainTc.text
                  ..port = portTc.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OpeningPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
