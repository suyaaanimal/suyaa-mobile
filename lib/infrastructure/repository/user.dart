import 'package:suyaa_mobile/infrastructure/data_model/sleep_server.dart';
import 'package:suyaa_mobile/infrastructure/service/server.dart';
import 'package:suyaa_mobile/infrastructure/constant/debug.dart';

class UserRepository {
  UserRepository(Server server) : _server = server;
  final Server _server;

  Future<List<SleepServerModel>> fetchSleepData(String accessToken) async {
    final jsonData =
        await _server.fetchSleepData(accessToken, mock: useMockData);
    if (!jsonData['status']) throw Exception('Server internal error');
    final data = jsonData['data'] as List<Map<String, dynamic>>;
    return data.map((e) => SleepServerModel.fromJson(e)).toList();
  }
}
