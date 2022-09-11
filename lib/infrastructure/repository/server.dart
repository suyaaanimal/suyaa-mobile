import 'package:suyaa_mobile/infrastructure/data_model/domain.dart';
import 'package:suyaa_mobile/infrastructure/service/server.dart';

class ServerRepository {
  ServerRepository({required this.server});

  final Server server;

  Domain get domain => server.domain;

  void updateDomain(String domain, int port) {
    server.domain
      ..domain = domain
      ..port = port;
  }
}
