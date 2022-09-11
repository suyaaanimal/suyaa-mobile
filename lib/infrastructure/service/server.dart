import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' show debugPrint;
import 'package:suyaa_mobile/infrastructure/constant/debug.dart';
import 'package:suyaa_mobile/infrastructure/constant/sleep_mock_data.dart';
import 'package:suyaa_mobile/infrastructure/data_model/domain.dart';

class Server {
  Domain domain = Domain();

  String _params(Map<String, String> q) {
    String? result;
    q.forEach((key, value) {
      if (result != null) {
        result = '$result&$key=$value';
      } else {
        result = '$key=$value';
      }
    });
    return result!;
  }

  Future<http.Response> _get(String path, String accessToken) =>
      http.get(Uri.parse('http://$domain$path'),
          headers: {"Authorization": "Bearer $accessToken"});

  Future<http.Response> _post({
    required String path,
    required Map<String, String> params,
    String? accessToken,
  }) =>
      accessToken == null
          ? http.post(Uri.parse('http://$domain$path'),
              body: _params(params),
              headers: {"Content-Type": "application/x-www-form-urlencoded"})
          : http.post(Uri.parse('http://$domain$path'),
              headers: {"Authorization": "Bearer $accessToken"});

  bool _success(int status) {
    if (200 <= status && status < 300) {
      return true;
    }
    return false;
  }

  Future<String> signin(String name, String password) async {
    String? accessToken;
    final response = await _post(
      path: '/auth/signin',
      params: {
        'username': name,
        'password': password,
      },
    );
    if (!_success(response.statusCode)) {
      throw Exception(response.statusCode.toString());
    }
    accessToken = json.decode(response.body)['access_token'];
    if (accessToken == null) {
      throw Exception('Server did not return access token');
    }

    debugPrint('Get the access token: $accessToken');
    return accessToken;
  }

  Future<void> signup(
      String name, String password, String walletAddress) async {
    final response = await _post(path: '/auth/signup', params: {
      'username': name,
      'password': password,
      'walletAddress': walletAddress
    });
    if (!_success(response.statusCode)) {
      throw Exception(
          '[Sever@Service] Could not sign up:${response.statusCode.toString()}');
    }
  }

  Future<void> sendFitbitToken(String token, String accessToken) async {
    _post(
      path: '/auth/fitbit/token',
      params: {'token': token},
      accessToken: accessToken,
    );
  }

  Future<Map<String, dynamic>> fetchProfile(String accessToken) async {
    final response = await _get('/auth/profile', accessToken);
    if (!_success(response.statusCode)) {
      throw Exception(response.statusCode);
    }
    final r = response.body;
    return {'username': r};
  }

  Future<Map<String, dynamic>> fetchSleepData(String token,
      {bool mock = false}) async {
    if (debug && mock) {
      await Future.delayed(const Duration(seconds: 1));
      return sleepMockData;
    }
    final response = await _get('/sleep', token);
    if (!_success(response.statusCode)) {
      throw Exception('Could not fetch test data');
    }
    return json.decode(response.body);
  }
}
