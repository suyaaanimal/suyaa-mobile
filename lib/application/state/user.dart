import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_server.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/not_logged_in_user_info.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';

@immutable
class UserState {
  const UserState({
    required this.userInfo,
    required this.sleepData,
  });

  UserState.init()
      : this(
          userInfo: NotLoggedInUserInfo(),
          sleepData: [],
        );

  final UserInfo userInfo;
  final List<SleepServerModel> sleepData;

  UserState copyWith({
    UserInfo? userInfo,
    List<SleepServerModel>? sleepData,
  }) {
    return UserState(
      userInfo: userInfo ?? this.userInfo,
      sleepData: sleepData ?? this.sleepData,
    );
  }
}
