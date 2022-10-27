// TODO(atahatah) 成長度合いなども保持して伝えられるように
abstract class UserInfo {
  late final bool signedIn;
  late String username;
  late String accessToken;
  String? walletAddress;
  bool get hasWalletAddress;
}
