import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suyaa_mobile/application/controller/auth.dart';
import 'package:suyaa_mobile/application/controller/server_setting.dart';
import 'package:suyaa_mobile/infrastructure/constant/default_domain.dart';

class ServerSettingPage extends StatefulWidget {
  const ServerSettingPage({super.key});

  @override
  State<ServerSettingPage> createState() => _ServerSettingPageState();
}

class _ServerSettingPageState extends State<ServerSettingPage> {
  late final TextEditingController domainTc;
  late final TextEditingController portTc;

  @override
  void initState() {
    super.initState();
    domainTc = TextEditingController();
    portTc = TextEditingController()
      ..text = context.read<ServerSetting>().portString;
  }

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
            const Text('If you are a test user, you can skip here.'),
            TextField(
              controller: domainTc,
              decoration: const InputDecoration(
                hintText: defaultDomain,
              ),
            ),
            TextField(
              controller: portTc,
              decoration: InputDecoration(
                hintText: defaultPort.toString(),
              ),
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                var domain = domainTc.text;
                if (domain.isEmpty) domain = defaultDomain;
                context.read<ServerSetting>().updateDomain(domain, portTc.text);
                // 本来ならAuthのコンストラクタ内で実行されるが、
                // 現在はサーバ情報を最初に設定させるため、ここで初期化処理を再実行している
                context.go('/');
                context.read<Auth>().initProfile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
