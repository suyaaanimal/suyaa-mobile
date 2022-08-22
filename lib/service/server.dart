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
      {"dateTime": "2022-06-01", "score": 07},
      {"dateTime": "2022-06-02", "score": 49},
      {"dateTime": "2022-06-03", "score": 73},
      {"dateTime": "2022-06-04", "score": 58},
      {"dateTime": "2022-06-05", "score": 30},
      {"dateTime": "2022-06-06", "score": 72},
      {"dateTime": "2022-06-07", "score": 44},
      {"dateTime": "2022-06-08", "score": 78},
      {"dateTime": "2022-06-09", "score": 23},
    ],
    "levels": [
      {"dateTime": "2022-06-01 00:00", "level": 1},
      {"dateTime": "2022-06-01 00:30", "level": 1},
      {"dateTime": "2022-06-01 01:00", "level": 1},
      {"dateTime": "2022-06-01 01:30", "level": 2},
      {"dateTime": "2022-06-01 02:00", "level": 2},
      {"dateTime": "2022-06-01 02:30", "level": 2},
      {"dateTime": "2022-06-01 03:00", "level": 1},
      {"dateTime": "2022-06-01 03:30", "level": 2},
      {"dateTime": "2022-06-01 04:00", "level": 0},
      {"dateTime": "2022-06-01 09:30", "level": 0},
      {"dateTime": "2022-06-01 10:00", "level": 3},
      {"dateTime": "2022-06-01 10:30", "level": 1},
      {"dateTime": "2022-06-01 11:00", "level": 0},
      {"dateTime": "2022-06-01 16:30", "level": 1},
      {"dateTime": "2022-06-01 17:00", "level": 0},
      {"dateTime": "2022-06-01 17:30", "level": 1},
      {"dateTime": "2022-06-01 18:00", "level": 1},
      {"dateTime": "2022-06-01 18:30", "level": 1},
      {"dateTime": "2022-06-01 19:00", "level": 1},
      {"dateTime": "2022-06-01 19:30", "level": 1},
      {"dateTime": "2022-06-01 20:00", "level": 1},
      {"dateTime": "2022-06-02 01:30", "level": 2},
      {"dateTime": "2022-06-02 02:00", "level": 3},
      {"dateTime": "2022-06-02 02:30", "level": 2},
      {"dateTime": "2022-06-02 03:00", "level": 3},
      {"dateTime": "2022-06-02 03:30", "level": 2},
      {"dateTime": "2022-06-02 04:00", "level": 2},
      {"dateTime": "2022-06-02 04:30", "level": 2},
      {"dateTime": "2022-06-02 05:00", "level": 2},
      {"dateTime": "2022-06-02 05:30", "level": 3},
      {"dateTime": "2022-06-02 06:00", "level": 1},
      {"dateTime": "2022-06-02 06:30", "level": 0},
      {"dateTime": "2022-06-02 15:00", "level": 0},
      {"dateTime": "2022-06-02 15:30", "level": 1},
      {"dateTime": "2022-06-02 16:00", "level": 0},
      {"dateTime": "2022-06-02 16:30", "level": 1},
      {"dateTime": "2022-06-02 17:00", "level": 1},
      {"dateTime": "2022-06-02 17:30", "level": 1},
      {"dateTime": "2022-06-02 18:00", "level": 0},
      {"dateTime": "2022-06-02 18:30", "level": 0},
      {"dateTime": "2022-06-03 00:00", "level": 0},
      {"dateTime": "2022-06-03 00:30", "level": 1},
      {"dateTime": "2022-06-03 01:00", "level": 0},
      {"dateTime": "2022-06-03 01:30", "level": 1},
      {"dateTime": "2022-06-03 02:00", "level": 1},
      {"dateTime": "2022-06-03 07:30", "level": 0},
      {"dateTime": "2022-06-03 08:00", "level": 0},
      {"dateTime": "2022-06-03 08:30", "level": 1},
      {"dateTime": "2022-06-03 09:00", "level": 2},
      {"dateTime": "2022-06-03 09:30", "level": 2},
      {"dateTime": "2022-06-03 10:00", "level": 1},
      {"dateTime": "2022-06-03 17:00", "level": 1},
      {"dateTime": "2022-06-03 17:30", "level": 0},
      {"dateTime": "2022-06-03 18:00", "level": 1},
      {"dateTime": "2022-06-03 18:30", "level": 1},
      {"dateTime": "2022-06-03 19:00", "level": 2},
      {"dateTime": "2022-06-03 19:30", "level": 2},
      {"dateTime": "2022-06-03 20:00", "level": 0},
      {"dateTime": "2022-06-03 20:30", "level": 0},
      {"dateTime": "2022-06-04 03:00", "level": 0},
      {"dateTime": "2022-06-04 03:30", "level": 0},
      {"dateTime": "2022-06-04 04:00", "level": 1},
      {"dateTime": "2022-06-04 04:30", "level": 2},
      {"dateTime": "2022-06-04 05:00", "level": 3},
      {"dateTime": "2022-06-04 05:30", "level": 1},
      {"dateTime": "2022-06-04 06:00", "level": 0},
      {"dateTime": "2022-06-04 14:00", "level": 1},
      {"dateTime": "2022-06-04 14:30", "level": 0},
      {"dateTime": "2022-06-04 15:00", "level": 1},
      {"dateTime": "2022-06-04 15:30", "level": 0},
      {"dateTime": "2022-06-04 16:00", "level": 1},
      {"dateTime": "2022-06-04 16:30", "level": 1},
      {"dateTime": "2022-06-04 22:00", "level": 0},
      {"dateTime": "2022-06-04 22:30", "level": 1},
      {"dateTime": "2022-06-04 23:00", "level": 0},
      {"dateTime": "2022-06-04 23:30", "level": 1},
      {"dateTime": "2022-06-05 00:00", "level": 2},
      {"dateTime": "2022-06-05 00:30", "level": 1},
      {"dateTime": "2022-06-05 01:00", "level": 2},
      {"dateTime": "2022-06-05 01:30", "level": 1},
      {"dateTime": "2022-06-05 02:00", "level": 1},
      {"dateTime": "2022-06-05 02:30", "level": 0},
      {"dateTime": "2022-06-05 03:00", "level": 0},
      {"dateTime": "2022-06-05 03:30", "level": 0},
      {"dateTime": "2022-06-05 10:00", "level": 0},
      {"dateTime": "2022-06-05 10:30", "level": 1},
      {"dateTime": "2022-06-05 11:00", "level": 0},
      {"dateTime": "2022-06-05 11:30", "level": 1},
      {"dateTime": "2022-06-05 12:00", "level": 0},
      {"dateTime": "2022-06-05 12:30", "level": 1},
      {"dateTime": "2022-06-05 13:00", "level": 0},
      {"dateTime": "2022-06-05 13:30", "level": 0},
      {"dateTime": "2022-06-05 14:00", "level": 0},
      {"dateTime": "2022-06-05 21:30", "level": 1},
      {"dateTime": "2022-06-05 22:00", "level": 2},
      {"dateTime": "2022-06-05 22:30", "level": 3},
      {"dateTime": "2022-06-05 23:00", "level": 2},
      {"dateTime": "2022-06-05 23:30", "level": 0},
      {"dateTime": "2022-06-06 00:00", "level": 0},
      {"dateTime": "2022-06-06 00:30", "level": 0},
      {"dateTime": "2022-06-06 01:00", "level": 0},
      {"dateTime": "2022-06-06 01:30", "level": 0},
      {"dateTime": "2022-06-06 02:00", "level": 1},
      {"dateTime": "2022-06-06 02:30", "level": 2},
      {"dateTime": "2022-06-06 03:00", "level": 3},
      {"dateTime": "2022-06-06 03:30", "level": 3},
      {"dateTime": "2022-06-06 04:00", "level": 2},
      {"dateTime": "2022-06-06 04:30", "level": 2},
      {"dateTime": "2022-06-06 05:00", "level": 1},
      {"dateTime": "2022-06-06 11:00", "level": 0},
      {"dateTime": "2022-06-06 11:30", "level": 1},
      {"dateTime": "2022-06-06 12:00", "level": 2},
      {"dateTime": "2022-06-06 12:30", "level": 0},
      {"dateTime": "2022-06-06 13:00", "level": 1},
      {"dateTime": "2022-06-06 13:30", "level": 1},
      {"dateTime": "2022-06-06 14:00", "level": 0},
      {"dateTime": "2022-06-06 19:30", "level": 1},
      {"dateTime": "2022-06-06 20:00", "level": 1},
      {"dateTime": "2022-06-06 20:30", "level": 2},
      {"dateTime": "2022-06-06 21:00", "level": 3},
      {"dateTime": "2022-06-06 21:30", "level": 3},
      {"dateTime": "2022-06-06 22:00", "level": 2},
      {"dateTime": "2022-06-06 22:30", "level": 2},
      {"dateTime": "2022-06-06 23:00", "level": 0},
      {"dateTime": "2022-06-06 23:30", "level": 0},
      {"dateTime": "2022-06-07 00:00", "level": 1},
      {"dateTime": "2022-06-07 06:30", "level": 1},
      {"dateTime": "2022-06-07 07:00", "level": 2},
      {"dateTime": "2022-06-07 07:30", "level": 1},
      {"dateTime": "2022-06-07 08:00", "level": 2},
      {"dateTime": "2022-06-07 08:30", "level": 2},
      {"dateTime": "2022-06-07 09:00", "level": 2},
      {"dateTime": "2022-06-07 09:30", "level": 1},
      {"dateTime": "2022-06-07 10:00", "level": 0},
      {"dateTime": "2022-06-07 17:00", "level": 0},
      {"dateTime": "2022-06-07 17:30", "level": 1},
      {"dateTime": "2022-06-07 18:00", "level": 1},
      {"dateTime": "2022-06-07 18:30", "level": 0},
      {"dateTime": "2022-06-08 00:00", "level": 2},
      {"dateTime": "2022-06-08 00:30", "level": 3},
      {"dateTime": "2022-06-08 01:00", "level": 2},
      {"dateTime": "2022-06-08 01:30", "level": 0},
      {"dateTime": "2022-06-08 02:00", "level": 0},
      {"dateTime": "2022-06-08 02:30", "level": 0},
      {"dateTime": "2022-06-08 03:00", "level": 0},
      {"dateTime": "2022-06-08 03:30", "level": 1},
      {"dateTime": "2022-06-08 04:00", "level": 0},
      {"dateTime": "2022-06-08 04:30", "level": 0},
      {"dateTime": "2022-06-08 05:00", "level": 1},
      {"dateTime": "2022-06-08 05:30", "level": 2},
      {"dateTime": "2022-06-08 06:00", "level": 1},
      {"dateTime": "2022-06-08 06:30", "level": 1},
      {"dateTime": "2022-06-08 07:00", "level": 0},
      {"dateTime": "2022-06-08 13:00", "level": 0},
      {"dateTime": "2022-06-08 13:30", "level": 1},
      {"dateTime": "2022-06-08 14:00", "level": 1},
      {"dateTime": "2022-06-08 14:30", "level": 0},
      {"dateTime": "2022-06-08 23:00", "level": 0},
      {"dateTime": "2022-06-08 23:30", "level": 1},
      {"dateTime": "2022-06-09 00:00", "level": 2},
      {"dateTime": "2022-06-09 00:30", "level": 1},
      {"dateTime": "2022-06-09 01:00", "level": 0},
      {"dateTime": "2022-06-09 01:30", "level": 1},
      {"dateTime": "2022-06-09 02:00", "level": 2},
      {"dateTime": "2022-06-09 02:30", "level": 0},
      {"dateTime": "2022-06-09 03:00", "level": 0},
      {"dateTime": "2022-06-09 09:00", "level": 0},
      {"dateTime": "2022-06-09 09:30", "level": 1},
      {"dateTime": "2022-06-09 10:00", "level": 0},
      {"dateTime": "2022-06-09 10:30", "level": 0},
      {"dateTime": "2022-06-09 11:00", "level": 0},
      {"dateTime": "2022-06-09 11:30", "level": 1},
      {"dateTime": "2022-06-09 12:00", "level": 2},
      {"dateTime": "2022-06-09 12:30", "level": 2},
      {"dateTime": "2022-06-09 13:00", "level": 3},
      {"dateTime": "2022-06-09 13:30", "level": 2},
      {"dateTime": "2022-06-09 14:00", "level": 2},
      {"dateTime": "2022-06-09 14:30", "level": 1},
      {"dateTime": "2022-06-09 22:00", "level": 0},
      {"dateTime": "2022-06-09 22:30", "level": 0},
      {"dateTime": "2022-06-09 23:00", "level": 0},
      {"dateTime": "2022-06-09 23:30", "level": 1},
    ]
  }
};
