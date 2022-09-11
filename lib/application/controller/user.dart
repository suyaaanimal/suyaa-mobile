import 'dart:async';

import 'package:state_notifier/state_notifier.dart';
import 'package:suyaa_mobile/application/state/user.dart';
import 'package:suyaa_mobile/infrastructure/data_model/dairy_sleep.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_model.dart';
import 'package:suyaa_mobile/infrastructure/data_model/sleep_server.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';
import 'package:suyaa_mobile/infrastructure/repository/user.dart';

/// 注意：Providerは必ずlazyにしないこと
class User extends StateNotifier<UserState> {
  User({
    required Stream<UserInfo> stream,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserState.init()) {
    stream
        .listen((newUserInfo) => state = state.copyWith(userInfo: newUserInfo));
  }

  final UserRepository _userRepository;

  Set<DateTime> get sleepDataKeys =>
      state.sleepData.map((e) => e.dateOfSleep).toSet();

  Map<DateTime, List<DairySleepModel>> get dairySleep => {
        for (final date in sleepDataKeys)
          date: state.sleepData
              .where((element) => element.dateOfSleep == date)
              .map((e) => DairySleepModel.fromServer(e))
              .toList()
      };

  Map<DateTime, Map<DateTime, SleepModel>> get sleepCalender => {
        for (final date in sleepDataKeys)
          date: {
            for (final s in state.sleepData
                .where((element) => element.dateOfSleep == date)
                .fold<List<SleepServerDataModel>>(
                    [],
                    ((previousValue, element) =>
                        [...previousValue, ...element.levels.data])))
              s.dateTime: SleepModel.fromServer(s)
          }
      };

  UserInfo get _userInfo => state.userInfo;
  String get name => _userInfo.username;
  String get _accessToken => _userInfo.accessToken;

  Future<bool> fetchSleepData() async {
    if (state.sleepData.isNotEmpty) return false;
    await refreshSleepData();
    return true;
  }

  Future<void> refreshSleepData() async {
    final data = await _userRepository.fetchSleepData(_accessToken);
    state = state.copyWith(sleepData: data);
  }
}
