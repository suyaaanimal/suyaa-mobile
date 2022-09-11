import 'package:shared_preferences/shared_preferences.dart';

enum Keys {
  accessToken,
}

class SharedPreferencesService {
  Future<String?> get accessToken async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Keys.accessToken.name);
  }

  Future<void> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Keys.accessToken.name, token);
  }

  Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Keys.accessToken.name);
  }
}
