import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/not_logged_in_user_info.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';
import 'package:suyaa_mobile/infrastructure/enum/auth_failed_reasons.dart';

@immutable
class AuthState {
  const AuthState({
    required this.userInfo,
    required this.loading,
    required this.failedReason,
  });

  AuthState.init()
      : this(
          userInfo: NotLoggedInUserInfo(),
          loading: false,
          failedReason: AuthFailedReasons.success,
        );

  final UserInfo userInfo;
  final bool loading;
  final AuthFailedReasons failedReason;

  AuthState copyWith({
    UserInfo? userInfo,
    bool? loading,
    AuthFailedReasons? failedReason,
  }) {
    return AuthState(
      userInfo: userInfo ?? this.userInfo,
      loading: loading ?? this.loading,
      failedReason: failedReason ?? this.failedReason,
    );
  }
}
