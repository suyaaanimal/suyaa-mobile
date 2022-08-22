import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rpg_font/const.dart';

import '../model/domain.dart';
import '../model/user.dart';
import 'package:http/http.dart';

class Server {
  Server(Domain domain) : user = User(domain.domain, domain.port);

  User user;
  bool test = false;

  Future<bool> signup(
      String name, String password, String walletAddress) async {
    if (user.domain.isEmpty || user.port.isEmpty || name == testUserName) {
      return false;
    }
    return await user.signup(name, password, walletAddress);
  }

  Future<bool> signin(String name, String password) async {
    if (name == testUserName) {
      if (password == testUserPassword) {
        test = true;
        return true;
      } else {
        return false;
      }
    } else {
      return await user.signin(name, password);
    }
  }

  Future fetchTestData() async {
    if (test) {
      return mockData;
    }
    final response =
        await get(Uri.parse("http://${user.domain}:${user.port}/testdata"));
    return json.decode(response.body);
  }
}

const mockData = {
  "status": true,
  "data": {
    "totalScore": [
      // efficiency
      {"dateTime": "2022-06-01", "score": 20},
      {"dateTime": "2022-06-02", "score": 30},
    ],
    "levels": [
      {"dateTime": "2022-06-01 19:00", "level": 3},
      {"dateTime": "2022-06-01 19:30", "level": 2},
      {"dateTime": "2022-06-01 20:00", "level": 3},
      {"dateTime": "2022-06-01 20:30", "level": 1},
      {"dateTime": "2022-06-01 21:00", "level": 3},
      {"dateTime": "2022-06-01 21:30", "level": 3},
      {"dateTime": "2022-06-02 19:00", "level": 3},
      {"dateTime": "2022-06-02 19:30", "level": 2},
      {"dateTime": "2022-06-02 20:00", "level": 3},
      {"dateTime": "2022-06-02 20:30", "level": 1},
      {"dateTime": "2022-06-02 21:00", "level": 3},
      {"dateTime": "2022-06-02 21:30", "level": 3},
    ]
  }
};
