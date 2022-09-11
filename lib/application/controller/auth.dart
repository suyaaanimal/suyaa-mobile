import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:suyaa_mobile/application/state/auth.dart';
import 'package:suyaa_mobile/infrastructure/constant/debug.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';
import 'package:suyaa_mobile/infrastructure/enum/auth_failed_reasons.dart';
import 'package:suyaa_mobile/infrastructure/repository/auth.dart';

class Auth extends StateNotifier<AuthState> {
  Auth({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState.init()) {
    if (!debug) initProfile();
  }

  final AuthRepository _authRepository;

  UserInfo get _userInfo => state.userInfo;

  bool get loading => state.loading;
  bool get signedIn => _userInfo.signedIn;
  String get _accessToken => _userInfo.accessToken;

  AuthFailedReasons get failedReasonStatus => state.failedReason;
  bool get failed => failedReasonStatus != AuthFailedReasons.success;
  String get failedReason {
    switch (failedReasonStatus) {
      case AuthFailedReasons.success:
        return '成功';
      case AuthFailedReasons.incorrectUsernameOrPassword:
        return 'ユーザ名かパスワードが間違っています。';
      case AuthFailedReasons.couldNotCreateNewUser:
        return '新規ユーザの作成に失敗しました。';
      case AuthFailedReasons.couldNotSignInWithLastToken:
        return '前回のアクセス時のセッションが切れました。';
    }
  }

  Future<void> signIn(String name, String password) async {
    try {
      state = state.copyWith(loading: true);
      if (debug) await Future.delayed(const Duration(seconds: 1));
      if (name == "" || password == "") {
        throw Exception('Fill out all the data');
      }
      final newUser = await _authRepository.signin(name, password);
      state = state.copyWith(
          userInfo: newUser, failedReason: AuthFailedReasons.success);
    } catch (e) {
      state = state.copyWith(
          failedReason: AuthFailedReasons.incorrectUsernameOrPassword);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> signUp(
      String name, String password, String walletAddress) async {
    try {
      state = state.copyWith(loading: true);
      if (debug) await Future.delayed(const Duration(seconds: 1));
      if (name == "" || password == "" || walletAddress == "") {
        throw Exception('Fill out all the data');
      }
      await _authRepository.signup(name, password, walletAddress);
      state = state.copyWith(failedReason: AuthFailedReasons.success);
    } catch (e) {
      state =
          state.copyWith(failedReason: AuthFailedReasons.couldNotCreateNewUser);
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void signOut() {
    final newUser = _authRepository.signOut();
    state = state.copyWith(
        userInfo: newUser, failedReason: AuthFailedReasons.success);
  }

  Future<void> initProfile() async {
    try {
      state = state.copyWith(loading: true);
      final newUser = await _authRepository.initProfile();
      state = state.copyWith(userInfo: newUser, loading: false);
    } catch (e) {
      state = state.copyWith(
          failedReason: AuthFailedReasons.couldNotSignInWithLastToken,
          loading: false);
    }
  }

  Future<void> connectFitbit() async {
    try {
      await _authRepository.connectFitbit(_accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteCashedAccessToken() =>
      _authRepository.deleteCashedAccessToken();
}
