import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';

class LoggedInUserInfo implements UserInfo {
  LoggedInUserInfo({
    required this.username,
    required this.accessToken,
  });

  @override
  bool signedIn = true;

  @override
  String username;

  @override
  String accessToken;

  @override
  String? walletAddress;

  @override
  bool get hasWalletAddress => walletAddress != null;

  @override
  String toString() {
    return 'LoggedInUserInfo:$username, $accessToken';
  }
}
