import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_font/components/login.dart';
import 'package:rpg_font/firebase_options.dart';
import 'package:rpg_font/components/deep_link.dart';
import 'package:rpg_font/model/domain.dart';
import 'package:rpg_font/model/metamask.dart';
import 'package:rpg_font/service/server.dart';
import 'components/opening.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.ios);

  runApp(MultiProvider(
    providers: [
      Provider<Domain>(create: (_) => Domain()),
      ProxyProvider<Domain, Server>(
          create: (context) => Server(context.read<Domain>()),
          update: (context, domain, server) =>
              (server?..user.updateDomain(domain.domain, domain.port)) ??
              Server(domain)),
      ChangeNotifierProvider<Metamask>(create: (_) => Metamask()),
    ],
    child: const MyApp(),
  ));
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
      routes: {'/fitbit_auth_callback': (_) => const FitbitAuthCallback()},
    );
  }
}

class InputDomainPage extends StatefulWidget {
  const InputDomainPage({Key? key}) : super(key: key);

  @override
  State<InputDomainPage> createState() => _InputDomainPageState();
}

class _InputDomainPageState extends State<InputDomainPage> {
  final domainTc = TextEditingController()..text = "localhost";
  final portTc = TextEditingController()..text = "3000";

  @override
  void dispose() {
    domainTc.dispose();
    portTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 最初のロードやサインインがしたい場合はこのコードを削除する
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await context.read<Server>().signin(testUserName, testUserPassword);
    //   if (!mounted) return;
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (_) => const MainPage()));
    // });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('サーバのIPアドレスかドメインとポート番号を入力してください。'),
            const Text('If you are a test user, you can skip here.'),
            TextField(
              controller: domainTc,
              decoration: const InputDecoration(
                hintText: 'localhost',
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
            ElevatedButton(
              child: const Text('skip the opening'),
              onPressed: () {
                context.read<Domain>()
                  ..domain = domainTc.text
                  ..port = portTc.text;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
