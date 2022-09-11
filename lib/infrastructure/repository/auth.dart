import 'dart:async';

import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/constant/debug.dart';
import 'package:suyaa_mobile/infrastructure/constant/test_user_data.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/loged_in_user_info.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/not_logged_in_user_info.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/test_user_info.dart';
import 'package:suyaa_mobile/infrastructure/data_model/user_info/user_info.dart';
import 'package:suyaa_mobile/infrastructure/service/oauth2.dart';
import 'package:suyaa_mobile/infrastructure/service/server.dart';
import 'package:suyaa_mobile/infrastructure/service/shared_preferences.dart';

class AuthRepository {
  AuthRepository({
    required Oauth2 oauth2,
    required Server server,
    required SharedPreferencesService sp,
  })  : _oauth2 = oauth2,
        _server = server,
        _sp = sp;

  final Oauth2 _oauth2;
  final Server _server;
  final SharedPreferencesService _sp;

  final userStream = StreamController<UserInfo>.broadcast()
    ..sink.add(NotLoggedInUserInfo());

  void updateDomain({required String domain, required String port}) {
    try {
      _server.domain.domain = domain;
      _server.domain.port = int.parse(port);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfo> signin(String name, String password) async {
    if (name == testUserName) {
      if (password != testUserPassword) {
        throw Exception('test user password failed');
      }
      await Future.delayed(const Duration(seconds: 1));
      final newUser = TestUserInfo();
      userStream.sink.add(newUser);
      return newUser;
    }

    final accessToken = await _server.signin(name, password);
    final newUser = LoggedInUserInfo(username: name, accessToken: accessToken);
    userStream.sink.add(newUser);

    await _sp.setAccessToken(accessToken);

    return newUser;
  }

  Future<void> signup(
      String name, String password, String walletAddress) async {
    if (name == testUserName) {
      throw Exception('do not sign in as test user');
    }

    await _server.signup(name, password, walletAddress);
  }

  UserInfo signOut() {
    final newUser = NotLoggedInUserInfo();
    userStream.sink.add(newUser);
    return newUser;
  }

  //TODO(__atah_atah): エラーハンドリングをちゃんとする
  Future<UserInfo> initProfile() async {
    if (debug) await Future.delayed(const Duration(seconds: 1));

    final token = await _sp.accessToken;
    final result = await _server.fetchProfile(token!);
    final newUser =
        LoggedInUserInfo(username: result['username'], accessToken: token);
    userStream.sink.add(newUser);
    return newUser;
  }

  Future<void> deleteCashedAccessToken() => _sp.removeAccessToken();
}
