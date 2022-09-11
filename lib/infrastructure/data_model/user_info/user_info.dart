abstract class UserInfo {
  late final bool signedIn;
  late String username;
  late String accessToken;
  String? walletAddress;
  bool get hasWalletAddress;
}
