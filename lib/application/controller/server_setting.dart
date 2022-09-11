import 'package:suyaa_mobile/infrastructure/repository/server.dart';

/// デバッグ用
///
/// デバッグでない場合はこのproviderを呼び出してはいけない
class ServerSetting {
  ServerSetting({
    required this.serverRepository,
  });

  final ServerRepository serverRepository;

  String get domain => serverRepository.domain.domain;
  int get port => serverRepository.domain.port;
  String get portString => serverRepository.domain.port.toString();

  void updateDomain(String domain, String portString) {
    int? port = int.tryParse(portString);
    if (port == null) throw Exception('Port cant parse in to number');
    serverRepository.updateDomain(domain, port);
  }
}
