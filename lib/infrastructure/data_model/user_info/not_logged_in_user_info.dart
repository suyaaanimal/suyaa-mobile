import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';

class NotLoggedInUserInfo implements UserInfo {
  @override
  bool signedIn = false;

  @override
  String get accessToken => throw NotLoggedInException();

  @override
  set accessToken(String _) => throw NotLoggedInException();
  @override
  String get username => throw NotLoggedInException();

  @override
  set username(String _) => throw NotLoggedInException();

  @override
  String? get walletAddress => throw NotLoggedInException();

  @override
  set walletAddress(_) => throw NotLoggedInException();

  @override
  bool get hasWalletAddress => throw NotLoggedInException();
}

class NotLoggedInException implements Exception {
  @override
  String toString() => 'Not Logged In Yet';
}
