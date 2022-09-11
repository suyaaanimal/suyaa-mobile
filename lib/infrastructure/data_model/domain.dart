import 'package:suyaa_mobile/infrastructure/constant/default_domain.dart';

class Domain {
  String domain = defaultDomain;
  int port = defaultPort;

  @override
  String toString() {
    return '$domain:$port';
  }
}
