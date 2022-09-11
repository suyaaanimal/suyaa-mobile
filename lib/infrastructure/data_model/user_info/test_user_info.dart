import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';

class TestUserInfo implements UserInfo {
  @override
  bool signedIn = true;

  /// そもそもサーバにアクセスしない
  @override
  String get accessToken => throw DoNotAccessToServerException();

  @override
  set accessToken(_) => throw DoNotAccessToServerException();

  @override
  String username = "testUser";

  @override
  String? walletAddress;

  @override
  final hasWalletAddress = false;
}

class DoNotAccessToServerException implements Exception {
  @override
  String toString() => 'This is test user.\nDO NOT access to the Server';
}
