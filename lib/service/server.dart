import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rpg_font/const.dart';
import 'package:rpg_font/service/oauth2.dart';

import '../model/domain.dart';
import '../model/user.dart';
import 'package:http/http.dart';

class Server {
  final _oauth2 = Oauth2();
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

  Future<void> connectFitbit() async {
    final token = await _oauth2.getToken();
    if (test) {
      debugPrint(token);
      return;
    } else {
      // TODO::サーバにトークンを送信
    }
  }
}

const mockData = {
  'status': true,
  'data': [
    {
      'dateOfSleep': '2022-08-01',
      'levels': [
        {
          'score': 13,
          'start': '2022-08-01 15:29',
          'duration': 9600000,
          'data': [
            {
              'dateTime': '2022-08-01 15:30:00',
              'level': 'wake',
              'seconds': 3060,
            },
            {
              'dateTime': '2022-08-01 16:28:00',
              'level': 'light',
              'seconds': 2370,
            },
            {
              'dateTime': '2022-08-01 17:11:30',
              'level': 'wake',
              'seconds': 2490,
            },
            {
              'dateTime': '2022-08-01 17:57:00',
              'level': 'deep',
              'seconds': 720,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-01 15:29:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-01 16:21:00',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-01 16:24:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-01 16:26:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-01 17:07:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-01 17:09:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-01 17:53:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-01 17:54:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-01 17:55:30',
              'level': 'light',
              'seconds': 90,
            },
          ]
        },
        {
          'score': 45,
          'start': '2022-08-01 23:56',
          'duration': 30450000,
          'data': [
            {
              'dateTime': '2022-08-01 23:58:00',
              'level': 'wake',
              'seconds': 1200,
            },
            {
              'dateTime': '2022-08-02 00:20:00',
              'level': 'wake',
              'seconds': 1110,
            },
            {
              'dateTime': '2022-08-02 00:38:30',
              'level': 'light',
              'seconds': 540,
            },
            {
              'dateTime': '2022-08-02 00:49:30',
              'level': 'deep',
              'seconds': 1740,
            },
            {
              'dateTime': '2022-08-02 01:18:30',
              'level': 'light',
              'seconds': 510,
            },
            {
              'dateTime': '2022-08-02 01:32:30',
              'level': 'wake',
              'seconds': 900,
            },
            {
              'dateTime': '2022-08-02 01:47:30',
              'level': 'light',
              'seconds': 240,
            },
            {
              'dateTime': '2022-08-02 01:51:30',
              'level': 'deep',
              'seconds': 1110,
            },
            {
              'dateTime': '2022-08-02 02:10:00',
              'level': 'light',
              'seconds': 1980,
            },
            {
              'dateTime': '2022-08-02 02:44:30',
              'level': 'light',
              'seconds': 2460,
            },
            {
              'dateTime': '2022-08-02 03:28:00',
              'level': 'light',
              'seconds': 1440,
            },
            {
              'dateTime': '2022-08-02 03:52:00',
              'level': 'deep',
              'seconds': 2190,
            },
            {
              'dateTime': '2022-08-02 04:32:00',
              'level': 'rem',
              'seconds': 1320,
            },
            {
              'dateTime': '2022-08-02 04:55:30',
              'level': 'rem',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-02 05:03:00',
              'level': 'deep',
              'seconds': 2190,
            },
            {
              'dateTime': '2022-08-02 05:40:30',
              'level': 'deep',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-02 05:53:00',
              'level': 'light',
              'seconds': 780,
            },
            {
              'dateTime': '2022-08-02 06:09:00',
              'level': 'wake',
              'seconds': 2610,
            },
            {
              'dateTime': '2022-08-02 06:56:00',
              'level': 'light',
              'seconds': 600,
            },
            {
              'dateTime': '2022-08-02 07:08:30',
              'level': 'wake',
              'seconds': 990,
            },
            {
              'dateTime': '2022-08-02 07:27:00',
              'level': 'wake',
              'seconds': 2820,
            },
            {
              'dateTime': '2022-08-02 08:19:00',
              'level': 'light',
              'seconds': 270,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-01 23:56:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 00:18:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 00:47:30',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 01:27:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-02 01:28:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-02 01:29:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 01:30:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 02:43:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 03:25:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-02 04:28:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 04:30:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 04:54:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 05:39:30',
              'level': 'rem',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-02 06:06:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 06:07:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 06:52:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-02 06:55:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-02 07:06:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-02 07:07:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 07:25:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 08:14:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 08:16:00',
              'level': 'deep',
              'seconds': 180,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-02',
      'levels': [
        {
          'score': 69,
          'start': '2022-08-02 15:20',
          'duration': 5490000,
          'data': [
            {
              'dateTime': '2022-08-02 15:23:00',
              'level': 'light',
              'seconds': 2160,
            },
            {
              'dateTime': '2022-08-02 15:59:00',
              'level': 'rem',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-02 16:18:30',
              'level': 'wake',
              'seconds': 2010,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-02 15:20:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-02 16:16:30',
              'level': 'light',
              'seconds': 120,
            },
          ]
        },
        {
          'score': 86,
          'start': '2022-08-02 19:56',
          'duration': 9600000,
          'data': [
            {
              'dateTime': '2022-08-02 19:56:30',
              'level': 'light',
              'seconds': 1890,
            },
            {
              'dateTime': '2022-08-02 20:31:00',
              'level': 'light',
              'seconds': 1440,
            },
            {
              'dateTime': '2022-08-02 21:01:00',
              'level': 'rem',
              'seconds': 2280,
            },
            {
              'dateTime': '2022-08-02 21:39:00',
              'level': 'deep',
              'seconds': 270,
            },
            {
              'dateTime': '2022-08-02 21:45:00',
              'level': 'wake',
              'seconds': 1800,
            },
            {
              'dateTime': '2022-08-02 22:17:30',
              'level': 'rem',
              'seconds': 1140,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-02 20:28:00',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 20:29:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 20:55:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-02 20:57:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 20:58:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-02 21:43:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-02 22:15:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-02 22:16:00',
              'level': 'deep',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-03',
      'levels': [
        {
          'score': 66,
          'start': '2022-08-03 14:56',
          'duration': 10800000,
          'data': [
            {
              'dateTime': '2022-08-03 14:56:00',
              'level': 'deep',
              'seconds': 2370,
            },
            {
              'dateTime': '2022-08-03 15:35:30',
              'level': 'rem',
              'seconds': 3120,
            },
            {
              'dateTime': '2022-08-03 16:27:30',
              'level': 'deep',
              'seconds': 1980,
            },
            {
              'dateTime': '2022-08-03 17:00:30',
              'level': 'light',
              'seconds': 1980,
            },
            {
              'dateTime': '2022-08-03 17:34:30',
              'level': 'wake',
              'seconds': 1290,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-03 17:33:30',
              'level': 'light',
              'seconds': 60,
            },
          ]
        },
        {
          'score': 22,
          'start': '2022-08-03 23:17',
          'duration': 24090000,
          'data': [
            {
              'dateTime': '2022-08-03 23:17:00',
              'level': 'light',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-03 23:30:30',
              'level': 'light',
              'seconds': 420,
            },
            {
              'dateTime': '2022-08-03 23:39:00',
              'level': 'light',
              'seconds': 780,
            },
            {
              'dateTime': '2022-08-03 23:54:00',
              'level': 'rem',
              'seconds': 2490,
            },
            {
              'dateTime': '2022-08-04 00:35:30',
              'level': 'deep',
              'seconds': 1620,
            },
            {
              'dateTime': '2022-08-04 01:05:30',
              'level': 'light',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-04 01:26:00',
              'level': 'deep',
              'seconds': 1350,
            },
            {
              'dateTime': '2022-08-04 01:48:30',
              'level': 'deep',
              'seconds': 1650,
            },
            {
              'dateTime': '2022-08-04 02:18:30',
              'level': 'wake',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-04 02:36:00',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-04 02:44:30',
              'level': 'deep',
              'seconds': 3030,
            },
            {
              'dateTime': '2022-08-04 03:36:30',
              'level': 'wake',
              'seconds': 1080,
            },
            {
              'dateTime': '2022-08-04 03:54:30',
              'level': 'deep',
              'seconds': 1560,
            },
            {
              'dateTime': '2022-08-04 04:20:30',
              'level': 'light',
              'seconds': 570,
            },
            {
              'dateTime': '2022-08-04 04:32:30',
              'level': 'light',
              'seconds': 1290,
            },
            {
              'dateTime': '2022-08-04 04:55:30',
              'level': 'light',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-04 05:35:30',
              'level': 'wake',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-04 05:52:30',
              'level': 'deep',
              'seconds': 360,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-03 23:29:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-03 23:37:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-03 23:52:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-04 01:02:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-04 01:04:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-04 02:16:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-04 02:43:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-04 03:35:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-04 04:30:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-04 04:54:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-04 05:31:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-04 05:32:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-04 05:48:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-04 05:49:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-04 05:51:00',
              'level': 'rem',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-04',
      'levels': [
        {
          'score': 51,
          'start': '2022-08-04 18:44',
          'duration': 12510000,
          'data': [
            {
              'dateTime': '2022-08-04 18:50:00',
              'level': 'deep',
              'seconds': 1890,
            },
            {
              'dateTime': '2022-08-04 19:21:30',
              'level': 'rem',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-04 19:50:00',
              'level': 'deep',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-04 20:02:00',
              'level': 'light',
              'seconds': 2550,
            },
            {
              'dateTime': '2022-08-04 20:44:30',
              'level': 'wake',
              'seconds': 1140,
            },
            {
              'dateTime': '2022-08-04 21:03:30',
              'level': 'light',
              'seconds': 270,
            },
            {
              'dateTime': '2022-08-04 21:08:00',
              'level': 'wake',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-04 21:21:30',
              'level': 'deep',
              'seconds': 870,
            },
            {
              'dateTime': '2022-08-04 21:36:00',
              'level': 'rem',
              'seconds': 2190,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-04 18:44:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-04 18:46:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-04 18:48:30',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-04 19:57:30',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-04 19:59:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-04 20:00:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-04 21:18:30',
              'level': 'light',
              'seconds': 180,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-05',
      'levels': [
        {
          'score': 4,
          'start': '2022-08-05 14:43',
          'duration': 9660000,
          'data': [
            {
              'dateTime': '2022-08-05 14:43:30',
              'level': 'deep',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-05 15:15:30',
              'level': 'light',
              'seconds': 390,
            },
            {
              'dateTime': '2022-08-05 15:23:00',
              'level': 'light',
              'seconds': 420,
            },
            {
              'dateTime': '2022-08-05 15:32:00',
              'level': 'light',
              'seconds': 1290,
            },
            {
              'dateTime': '2022-08-05 15:58:00',
              'level': 'rem',
              'seconds': 2010,
            },
            {
              'dateTime': '2022-08-05 16:31:30',
              'level': 'deep',
              'seconds': 1830,
            },
            {
              'dateTime': '2022-08-05 17:10:30',
              'level': 'wake',
              'seconds': 840,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-05 15:22:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-05 15:30:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-05 15:53:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-05 15:55:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-05 17:02:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-05 17:04:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-05 17:06:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-05 17:08:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-05 17:09:30',
              'level': 'light',
              'seconds': 60,
            },
          ]
        },
        {
          'score': 68,
          'start': '2022-08-05 23:29',
          'duration': 32040000,
          'data': [
            {
              'dateTime': '2022-08-05 23:29:00',
              'level': 'light',
              'seconds': 600,
            },
            {
              'dateTime': '2022-08-05 23:43:00',
              'level': 'light',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-05 23:54:00',
              'level': 'deep',
              'seconds': 2340,
            },
            {
              'dateTime': '2022-08-06 00:33:00',
              'level': 'rem',
              'seconds': 1650,
            },
            {
              'dateTime': '2022-08-06 01:00:30',
              'level': 'deep',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-06 01:18:00',
              'level': 'light',
              'seconds': 690,
            },
            {
              'dateTime': '2022-08-06 01:29:30',
              'level': 'rem',
              'seconds': 2490,
            },
            {
              'dateTime': '2022-08-06 02:11:00',
              'level': 'deep',
              'seconds': 2730,
            },
            {
              'dateTime': '2022-08-06 02:59:00',
              'level': 'light',
              'seconds': 390,
            },
            {
              'dateTime': '2022-08-06 03:08:30',
              'level': 'light',
              'seconds': 2490,
            },
            {
              'dateTime': '2022-08-06 03:50:00',
              'level': 'deep',
              'seconds': 3000,
            },
            {
              'dateTime': '2022-08-06 04:40:00',
              'level': 'rem',
              'seconds': 720,
            },
            {
              'dateTime': '2022-08-06 04:52:00',
              'level': 'deep',
              'seconds': 570,
            },
            {
              'dateTime': '2022-08-06 05:01:30',
              'level': 'light',
              'seconds': 3120,
            },
            {
              'dateTime': '2022-08-06 05:58:00',
              'level': 'deep',
              'seconds': 870,
            },
            {
              'dateTime': '2022-08-06 06:12:30',
              'level': 'light',
              'seconds': 390,
            },
            {
              'dateTime': '2022-08-06 06:19:00',
              'level': 'wake',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-06 06:22:30',
              'level': 'light',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-06 06:57:00',
              'level': 'light',
              'seconds': 960,
            },
            {
              'dateTime': '2022-08-06 07:14:30',
              'level': 'light',
              'seconds': 1200,
            },
            {
              'dateTime': '2022-08-06 07:34:30',
              'level': 'deep',
              'seconds': 570,
            },
            {
              'dateTime': '2022-08-06 07:54:00',
              'level': 'light',
              'seconds': 390,
            },
            {
              'dateTime': '2022-08-06 08:00:30',
              'level': 'deep',
              'seconds': 1350,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-05 23:39:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-05 23:41:00',
              'level': 'rem',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-05 23:42:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-05 23:46:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-05 23:48:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-05 23:50:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-05 23:52:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-06 02:56:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-06 02:58:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-06 03:05:30',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-06 05:53:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-06 05:55:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-06 06:54:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-06 07:13:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-06 07:44:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-06 07:46:30',
              'level': 'wake',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-06 07:47:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-06 07:49:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-06 07:51:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-06 07:53:00',
              'level': 'wake',
              'seconds': 60,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-06',
      'levels': [
        {
          'score': 38,
          'start': '2022-08-06 18:29',
          'duration': 3390000,
          'data': [
            {
              'dateTime': '2022-08-06 18:31:30',
              'level': 'wake',
              'seconds': 390,
            },
            {
              'dateTime': '2022-08-06 18:38:00',
              'level': 'light',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-06 18:41:30',
              'level': 'wake',
              'seconds': 2430,
            },
            {
              'dateTime': '2022-08-06 19:22:00',
              'level': 'light',
              'seconds': 240,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-06 18:29:30',
              'level': 'light',
              'seconds': 120,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-07',
      'levels': [
        {
          'score': 19,
          'start': '2022-08-07 00:49',
          'duration': 21960000,
          'data': [
            {
              'dateTime': '2022-08-07 00:51:30',
              'level': 'rem',
              'seconds': 2340,
            },
            {
              'dateTime': '2022-08-07 01:33:30',
              'level': 'light',
              'seconds': 2640,
            },
            {
              'dateTime': '2022-08-07 02:20:00',
              'level': 'light',
              'seconds': 690,
            },
            {
              'dateTime': '2022-08-07 02:31:30',
              'level': 'wake',
              'seconds': 2100,
            },
            {
              'dateTime': '2022-08-07 03:08:30',
              'level': 'light',
              'seconds': 1620,
            },
            {
              'dateTime': '2022-08-07 03:35:30',
              'level': 'deep',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-07 03:53:00',
              'level': 'wake',
              'seconds': 1830,
            },
            {
              'dateTime': '2022-08-07 04:27:00',
              'level': 'deep',
              'seconds': 2670,
            },
            {
              'dateTime': '2022-08-07 05:11:30',
              'level': 'rem',
              'seconds': 2550,
            },
            {
              'dateTime': '2022-08-07 05:54:00',
              'level': 'deep',
              'seconds': 1860,
            },
            {
              'dateTime': '2022-08-07 06:25:00',
              'level': 'light',
              'seconds': 1350,
            },
            {
              'dateTime': '2022-08-07 06:47:30',
              'level': 'deep',
              'seconds': 480,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-07 00:49:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-07 01:30:30',
              'level': 'deep',
              'seconds': 0,
            },
            {
              'dateTime': '2022-08-07 01:30:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-07 01:32:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-07 02:17:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-07 03:06:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-07 04:23:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-07 04:25:00',
              'level': 'light',
              'seconds': 120,
            },
          ]
        },
        {
          'score': 79,
          'start': '2022-08-07 16:28',
          'duration': 5970000,
          'data': [
            {
              'dateTime': '2022-08-07 16:30:30',
              'level': 'deep',
              'seconds': 2880,
            },
            {
              'dateTime': '2022-08-07 17:18:30',
              'level': 'light',
              'seconds': 1020,
            },
            {
              'dateTime': '2022-08-07 17:35:30',
              'level': 'wake',
              'seconds': 1140,
            },
            {
              'dateTime': '2022-08-07 17:55:30',
              'level': 'wake',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-07 18:00:30',
              'level': 'wake',
              'seconds': 420,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-07 16:28:30',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-07 17:54:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-07 17:59:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-07 18:07:30',
              'level': 'light',
              'seconds': 30,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-08',
      'levels': [
        {
          'score': 11,
          'start': '2022-08-08 00:40',
          'duration': 30660000,
          'data': [
            {
              'dateTime': '2022-08-08 00:40:30',
              'level': 'deep',
              'seconds': 1980,
            },
            {
              'dateTime': '2022-08-08 01:13:30',
              'level': 'rem',
              'seconds': 1200,
            },
            {
              'dateTime': '2022-08-08 01:33:30',
              'level': 'deep',
              'seconds': 1620,
            },
            {
              'dateTime': '2022-08-08 02:00:30',
              'level': 'light',
              'seconds': 1320,
            },
            {
              'dateTime': '2022-08-08 02:31:30',
              'level': 'rem',
              'seconds': 870,
            },
            {
              'dateTime': '2022-08-08 02:46:00',
              'level': 'deep',
              'seconds': 1620,
            },
            {
              'dateTime': '2022-08-08 03:17:00',
              'level': 'deep',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-08 03:21:30',
              'level': 'wake',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-08 04:01:30',
              'level': 'light',
              'seconds': 1170,
            },
            {
              'dateTime': '2022-08-08 04:21:00',
              'level': 'deep',
              'seconds': 2730,
            },
            {
              'dateTime': '2022-08-08 05:08:30',
              'level': 'wake',
              'seconds': 2730,
            },
            {
              'dateTime': '2022-08-08 05:58:00',
              'level': 'deep',
              'seconds': 2220,
            },
            {
              'dateTime': '2022-08-08 06:35:00',
              'level': 'rem',
              'seconds': 2280,
            },
            {
              'dateTime': '2022-08-08 07:13:00',
              'level': 'deep',
              'seconds': 2880,
            },
            {
              'dateTime': '2022-08-08 08:03:30',
              'level': 'light',
              'seconds': 2100,
            },
            {
              'dateTime': '2022-08-08 08:39:30',
              'level': 'light',
              'seconds': 390,
            },
            {
              'dateTime': '2022-08-08 08:46:00',
              'level': 'deep',
              'seconds': 1530,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-08 02:22:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-08 02:24:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-08 02:26:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-08 02:28:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-08 02:29:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-08 03:13:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-08 03:15:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-08 03:20:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-08 03:53:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-08 03:54:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-08 03:56:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-08 03:58:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-08 03:59:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-08 05:06:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-08 05:54:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-08 05:55:30',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-08 08:01:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-08 08:03:00',
              'level': 'wake',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-08 08:38:30',
              'level': 'wake',
              'seconds': 60,
            },
          ]
        },
        {
          'score': 99,
          'start': '2022-08-08 16:47',
          'duration': 6150000,
          'data': [
            {
              'dateTime': '2022-08-08 16:53:00',
              'level': 'light',
              'seconds': 2820,
            },
            {
              'dateTime': '2022-08-08 17:44:00',
              'level': 'rem',
              'seconds': 2430,
            },
            {
              'dateTime': '2022-08-08 18:24:30',
              'level': 'deep',
              'seconds': 330,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-08 16:47:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-08 16:49:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-08 16:50:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-08 17:40:00',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-08 17:43:00',
              'level': 'light',
              'seconds': 60,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-09',
      'levels': [
        {
          'score': 71,
          'start': '2022-08-09 00:23',
          'duration': 22530000,
          'data': [
            {
              'dateTime': '2022-08-09 00:23:30',
              'level': 'rem',
              'seconds': 2070,
            },
            {
              'dateTime': '2022-08-09 01:03:30',
              'level': 'wake',
              'seconds': 900,
            },
            {
              'dateTime': '2022-08-09 01:18:30',
              'level': 'light',
              'seconds': 1680,
            },
            {
              'dateTime': '2022-08-09 01:49:30',
              'level': 'deep',
              'seconds': 2550,
            },
            {
              'dateTime': '2022-08-09 02:38:30',
              'level': 'deep',
              'seconds': 2370,
            },
            {
              'dateTime': '2022-08-09 03:19:30',
              'level': 'wake',
              'seconds': 2910,
            },
            {
              'dateTime': '2022-08-09 04:08:00',
              'level': 'light',
              'seconds': 2400,
            },
            {
              'dateTime': '2022-08-09 04:48:00',
              'level': 'wake',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-09 04:57:00',
              'level': 'light',
              'seconds': 1620,
            },
            {
              'dateTime': '2022-08-09 05:24:00',
              'level': 'wake',
              'seconds': 3090,
            },
            {
              'dateTime': '2022-08-09 06:16:30',
              'level': 'deep',
              'seconds': 1350,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-09 00:58:00',
              'level': 'deep',
              'seconds': 0,
            },
            {
              'dateTime': '2022-08-09 00:58:00',
              'level': 'rem',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-09 01:01:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-09 01:02:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-09 01:46:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-09 01:48:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-09 02:32:00',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-09 02:33:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-09 02:36:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-09 02:37:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-09 03:18:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-09 04:51:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-09 04:52:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-09 04:54:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-09 04:55:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-09 06:15:30',
              'level': 'light',
              'seconds': 60,
            },
          ]
        },
        {
          'score': 85,
          'start': '2022-08-09 16:03',
          'duration': 9300000,
          'data': [
            {
              'dateTime': '2022-08-09 16:03:00',
              'level': 'deep',
              'seconds': 3060,
            },
            {
              'dateTime': '2022-08-09 16:54:00',
              'level': 'light',
              'seconds': 780,
            },
            {
              'dateTime': '2022-08-09 17:07:00',
              'level': 'deep',
              'seconds': 1740,
            },
            {
              'dateTime': '2022-08-09 17:36:00',
              'level': 'rem',
              'seconds': 2910,
            },
            {
              'dateTime': '2022-08-09 18:26:00',
              'level': 'light',
              'seconds': 720,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-09 18:24:30',
              'level': 'deep',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-10',
      'levels': [
        {
          'score': 20,
          'start': '2022-08-10 00:25',
          'duration': 22200000,
          'data': [
            {
              'dateTime': '2022-08-10 00:27:00',
              'level': 'light',
              'seconds': 2430,
            },
            {
              'dateTime': '2022-08-10 01:07:30',
              'level': 'wake',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-10 01:18:00',
              'level': 'light',
              'seconds': 1080,
            },
            {
              'dateTime': '2022-08-10 01:37:30',
              'level': 'light',
              'seconds': 1680,
            },
            {
              'dateTime': '2022-08-10 02:07:30',
              'level': 'rem',
              'seconds': 2010,
            },
            {
              'dateTime': '2022-08-10 02:41:30',
              'level': 'light',
              'seconds': 780,
            },
            {
              'dateTime': '2022-08-10 02:54:30',
              'level': 'wake',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-10 03:31:30',
              'level': 'wake',
              'seconds': 1890,
            },
            {
              'dateTime': '2022-08-10 04:05:00',
              'level': 'wake',
              'seconds': 1440,
            },
            {
              'dateTime': '2022-08-10 04:43:00',
              'level': 'light',
              'seconds': 2820,
            },
            {
              'dateTime': '2022-08-10 05:35:00',
              'level': 'rem',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-10 05:38:30',
              'level': 'deep',
              'seconds': 690,
            },
            {
              'dateTime': '2022-08-10 05:51:30',
              'level': 'deep',
              'seconds': 1830,
            },
            {
              'dateTime': '2022-08-10 06:22:00',
              'level': 'light',
              'seconds': 780,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-10 00:25:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 01:36:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 02:05:30',
              'level': 'wake',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-10 02:06:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 02:41:00',
              'level': 'deep',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-10 03:30:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 04:03:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 04:29:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 04:31:00',
              'level': 'deep',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-10 04:34:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-10 04:35:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-10 04:37:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 04:39:30',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 04:41:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 05:30:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 05:32:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 05:33:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 05:50:00',
              'level': 'rem',
              'seconds': 90,
            },
          ]
        },
        {
          'score': 9,
          'start': '2022-08-10 15:27',
          'duration': 6360000,
          'data': [
            {
              'dateTime': '2022-08-10 15:27:00',
              'level': 'deep',
              'seconds': 1950,
            },
            {
              'dateTime': '2022-08-10 16:02:30',
              'level': 'light',
              'seconds': 1140,
            },
            {
              'dateTime': '2022-08-10 16:24:30',
              'level': 'light',
              'seconds': 1650,
            },
            {
              'dateTime': '2022-08-10 16:56:30',
              'level': 'light',
              'seconds': 390,
            },
            {
              'dateTime': '2022-08-10 17:08:30',
              'level': 'wake',
              'seconds': 270,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-10 15:59:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-10 16:00:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 16:21:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 16:23:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-10 16:52:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-10 16:53:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-10 16:54:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-10 17:03:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 17:04:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 17:06:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-10 17:07:00',
              'level': 'light',
              'seconds': 90,
            },
          ]
        },
        {
          'score': 3,
          'start': '2022-08-10 21:50',
          'duration': 28020000,
          'data': [
            {
              'dateTime': '2022-08-10 21:53:00',
              'level': 'wake',
              'seconds': 240,
            },
            {
              'dateTime': '2022-08-10 21:59:00',
              'level': 'deep',
              'seconds': 480,
            },
            {
              'dateTime': '2022-08-10 22:17:00',
              'level': 'wake',
              'seconds': 1380,
            },
            {
              'dateTime': '2022-08-10 22:42:00',
              'level': 'wake',
              'seconds': 2580,
            },
            {
              'dateTime': '2022-08-10 23:25:00',
              'level': 'light',
              'seconds': 1500,
            },
            {
              'dateTime': '2022-08-10 23:50:00',
              'level': 'wake',
              'seconds': 360,
            },
            {
              'dateTime': '2022-08-11 00:02:00',
              'level': 'light',
              'seconds': 720,
            },
            {
              'dateTime': '2022-08-11 00:16:00',
              'level': 'rem',
              'seconds': 2580,
            },
            {
              'dateTime': '2022-08-11 01:01:00',
              'level': 'light',
              'seconds': 2910,
            },
            {
              'dateTime': '2022-08-11 01:49:30',
              'level': 'wake',
              'seconds': 2790,
            },
            {
              'dateTime': '2022-08-11 02:36:00',
              'level': 'light',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-11 03:11:30',
              'level': 'deep',
              'seconds': 1170,
            },
            {
              'dateTime': '2022-08-11 03:33:00',
              'level': 'deep',
              'seconds': 1800,
            },
            {
              'dateTime': '2022-08-11 04:03:00',
              'level': 'rem',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-11 04:23:30',
              'level': 'deep',
              'seconds': 3090,
            },
            {
              'dateTime': '2022-08-11 05:22:00',
              'level': 'deep',
              'seconds': 900,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-10 21:50:00',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-10 21:57:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 22:07:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-10 22:08:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 22:10:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-10 22:13:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 22:15:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 22:40:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-10 23:56:00',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-10 23:59:00',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-11 00:14:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 00:59:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 03:31:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 05:15:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-11 05:16:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-11 05:18:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 05:20:30',
              'level': 'rem',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-11',
      'levels': [
        {
          'score': 64,
          'start': '2022-08-11 17:55',
          'duration': 7890000,
          'data': [
            {
              'dateTime': '2022-08-11 17:58:30',
              'level': 'light',
              'seconds': 2010,
            },
            {
              'dateTime': '2022-08-11 18:34:00',
              'level': 'light',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-11 18:44:30',
              'level': 'wake',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-11 19:18:30',
              'level': 'wake',
              'seconds': 2190,
            },
            {
              'dateTime': '2022-08-11 19:57:30',
              'level': 'rem',
              'seconds': 540,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-11 17:55:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-11 17:56:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 18:32:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 19:13:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 19:15:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-11 19:16:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-11 19:55:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-11 19:56:30',
              'level': 'deep',
              'seconds': 60,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-12',
      'levels': [
        {
          'score': 51,
          'start': '2022-08-12 01:25',
          'duration': 21390000,
          'data': [
            {
              'dateTime': '2022-08-12 01:27:30',
              'level': 'light',
              'seconds': 2820,
            },
            {
              'dateTime': '2022-08-12 02:14:30',
              'level': 'wake',
              'seconds': 1410,
            },
            {
              'dateTime': '2022-08-12 02:38:00',
              'level': 'light',
              'seconds': 1140,
            },
            {
              'dateTime': '2022-08-12 02:59:30',
              'level': 'wake',
              'seconds': 2580,
            },
            {
              'dateTime': '2022-08-12 03:44:00',
              'level': 'wake',
              'seconds': 2820,
            },
            {
              'dateTime': '2022-08-12 04:34:00',
              'level': 'light',
              'seconds': 2580,
            },
            {
              'dateTime': '2022-08-12 05:19:00',
              'level': 'light',
              'seconds': 2940,
            },
            {
              'dateTime': '2022-08-12 06:09:30',
              'level': 'light',
              'seconds': 330,
            },
            {
              'dateTime': '2022-08-12 06:15:00',
              'level': 'wake',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-12 06:36:30',
              'level': 'light',
              'seconds': 930,
            },
            {
              'dateTime': '2022-08-12 06:52:00',
              'level': 'wake',
              'seconds': 1080,
            },
            {
              'dateTime': '2022-08-12 07:10:00',
              'level': 'light',
              'seconds': 300,
            },
            {
              'dateTime': '2022-08-12 07:18:30',
              'level': 'deep',
              'seconds': 210,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-12 01:25:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-12 01:26:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-12 02:57:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-12 02:58:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-12 03:42:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-12 04:31:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-12 04:33:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-12 05:17:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-12 06:08:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-12 06:32:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-12 06:35:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-12 07:15:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-12 07:16:30',
              'level': 'light',
              'seconds': 120,
            },
          ]
        },
        {
          'score': 2,
          'start': '2022-08-12 16:18',
          'duration': 11910000,
          'data': [
            {
              'dateTime': '2022-08-12 16:19:00',
              'level': 'wake',
              'seconds': 1350,
            },
            {
              'dateTime': '2022-08-12 16:41:30',
              'level': 'light',
              'seconds': 2040,
            },
            {
              'dateTime': '2022-08-12 17:15:30',
              'level': 'deep',
              'seconds': 1170,
            },
            {
              'dateTime': '2022-08-12 17:35:00',
              'level': 'deep',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-12 17:52:30',
              'level': 'light',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-12 18:13:00',
              'level': 'wake',
              'seconds': 2670,
            },
            {
              'dateTime': '2022-08-12 18:57:30',
              'level': 'light',
              'seconds': 2340,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-12 16:18:00',
              'level': 'light',
              'seconds': 60,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-13',
      'levels': [
        {
          'score': 80,
          'start': '2022-08-13 00:27',
          'duration': 19380000,
          'data': [
            {
              'dateTime': '2022-08-13 00:27:00',
              'level': 'deep',
              'seconds': 1890,
            },
            {
              'dateTime': '2022-08-13 01:03:30',
              'level': 'deep',
              'seconds': 540,
            },
            {
              'dateTime': '2022-08-13 01:12:30',
              'level': 'rem',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-13 01:24:00',
              'level': 'deep',
              'seconds': 2730,
            },
            {
              'dateTime': '2022-08-13 02:09:30',
              'level': 'light',
              'seconds': 2490,
            },
            {
              'dateTime': '2022-08-13 03:00:30',
              'level': 'light',
              'seconds': 2970,
            },
            {
              'dateTime': '2022-08-13 03:50:00',
              'level': 'wake',
              'seconds': 1680,
            },
            {
              'dateTime': '2022-08-13 04:18:00',
              'level': 'light',
              'seconds': 570,
            },
            {
              'dateTime': '2022-08-13 04:32:00',
              'level': 'deep',
              'seconds': 1950,
            },
            {
              'dateTime': '2022-08-13 05:04:30',
              'level': 'wake',
              'seconds': 2730,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-13 00:58:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-13 01:01:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-13 01:02:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-13 01:20:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-13 01:21:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-13 02:51:00',
              'level': 'deep',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-13 02:54:00',
              'level': 'light',
              'seconds': 0,
            },
            {
              'dateTime': '2022-08-13 02:54:00',
              'level': 'deep',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-13 02:57:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-13 02:58:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-13 04:27:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-13 04:29:30',
              'level': 'rem',
              'seconds': 150,
            },
          ]
        },
        {
          'score': 98,
          'start': '2022-08-13 13:41',
          'duration': 7620000,
          'data': [
            {
              'dateTime': '2022-08-13 13:41:00',
              'level': 'light',
              'seconds': 2760,
            },
            {
              'dateTime': '2022-08-13 14:27:00',
              'level': 'wake',
              'seconds': 2400,
            },
            {
              'dateTime': '2022-08-13 15:08:00',
              'level': 'wake',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-13 15:43:30',
              'level': 'light',
              'seconds': 270,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-13 15:07:00',
              'level': 'light',
              'seconds': 60,
            },
          ]
        },
        {
          'score': 31,
          'start': '2022-08-13 19:38',
          'duration': 7830000,
          'data': [
            {
              'dateTime': '2022-08-13 19:38:30',
              'level': 'deep',
              'seconds': 1200,
            },
            {
              'dateTime': '2022-08-13 20:01:30',
              'level': 'deep',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-13 20:36:30',
              'level': 'light',
              'seconds': 1770,
            },
            {
              'dateTime': '2022-08-13 21:06:00',
              'level': 'deep',
              'seconds': 360,
            },
            {
              'dateTime': '2022-08-13 21:12:00',
              'level': 'rem',
              'seconds': 1110,
            },
            {
              'dateTime': '2022-08-13 21:31:30',
              'level': 'rem',
              'seconds': 1050,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-13 19:58:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-13 20:33:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-13 20:34:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-13 21:30:30',
              'level': 'deep',
              'seconds': 60,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-14',
      'levels': [
        {
          'score': 43,
          'start': '2022-08-14 01:52',
          'duration': 27150000,
          'data': [
            {
              'dateTime': '2022-08-14 01:52:00',
              'level': 'deep',
              'seconds': 2580,
            },
            {
              'dateTime': '2022-08-14 02:36:30',
              'level': 'wake',
              'seconds': 1680,
            },
            {
              'dateTime': '2022-08-14 03:10:00',
              'level': 'light',
              'seconds': 2880,
            },
            {
              'dateTime': '2022-08-14 03:58:00',
              'level': 'deep',
              'seconds': 330,
            },
            {
              'dateTime': '2022-08-14 04:03:30',
              'level': 'light',
              'seconds': 2940,
            },
            {
              'dateTime': '2022-08-14 04:56:30',
              'level': 'deep',
              'seconds': 3120,
            },
            {
              'dateTime': '2022-08-14 05:48:30',
              'level': 'wake',
              'seconds': 2430,
            },
            {
              'dateTime': '2022-08-14 06:31:30',
              'level': 'wake',
              'seconds': 3090,
            },
            {
              'dateTime': '2022-08-14 07:23:00',
              'level': 'light',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-14 07:40:00',
              'level': 'wake',
              'seconds': 1200,
            },
            {
              'dateTime': '2022-08-14 08:02:30',
              'level': 'light',
              'seconds': 960,
            },
            {
              'dateTime': '2022-08-14 08:18:30',
              'level': 'deep',
              'seconds': 870,
            },
            {
              'dateTime': '2022-08-14 08:35:30',
              'level': 'wake',
              'seconds': 1800,
            },
            {
              'dateTime': '2022-08-14 09:05:30',
              'level': 'deep',
              'seconds': 1140,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-14 02:35:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-14 03:04:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-14 03:06:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-14 03:08:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-14 04:52:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-14 04:54:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-14 06:29:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-14 07:35:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-14 07:38:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-14 08:00:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-14 08:01:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-14 08:33:00',
              'level': 'light',
              'seconds': 150,
            },
          ]
        },
        {
          'score': 2,
          'start': '2022-08-14 15:22',
          'duration': 2040000,
          'data': [
            {
              'dateTime': '2022-08-14 15:25:30',
              'level': 'light',
              'seconds': 1860,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-14 15:22:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-14 15:25:30',
              'level': 'wake',
              'seconds': 0,
            },
          ]
        },
        {
          'score': 88,
          'start': '2022-08-14 19:25',
          'duration': 3540000,
          'data': [
            {
              'dateTime': '2022-08-14 19:25:00',
              'level': 'rem',
              'seconds': 1590,
            },
            {
              'dateTime': '2022-08-14 19:51:30',
              'level': 'light',
              'seconds': 1140,
            },
            {
              'dateTime': '2022-08-14 20:12:30',
              'level': 'wake',
              'seconds': 660,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-14 20:10:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-14 20:23:30',
              'level': 'light',
              'seconds': 30,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-15',
      'levels': [
        {
          'score': 24,
          'start': '2022-08-15 01:05',
          'duration': 21930000,
          'data': [
            {
              'dateTime': '2022-08-15 01:15:30',
              'level': 'deep',
              'seconds': 2760,
            },
            {
              'dateTime': '2022-08-15 02:03:30',
              'level': 'rem',
              'seconds': 660,
            },
            {
              'dateTime': '2022-08-15 02:16:00',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-15 02:23:30',
              'level': 'deep',
              'seconds': 1410,
            },
            {
              'dateTime': '2022-08-15 02:48:30',
              'level': 'deep',
              'seconds': 2370,
            },
            {
              'dateTime': '2022-08-15 03:30:00',
              'level': 'rem',
              'seconds': 540,
            },
            {
              'dateTime': '2022-08-15 03:40:00',
              'level': 'light',
              'seconds': 1110,
            },
            {
              'dateTime': '2022-08-15 04:00:30',
              'level': 'light',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-15 04:29:00',
              'level': 'wake',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-15 05:01:00',
              'level': 'light',
              'seconds': 2760,
            },
            {
              'dateTime': '2022-08-15 05:48:30',
              'level': 'light',
              'seconds': 600,
            },
            {
              'dateTime': '2022-08-15 05:58:30',
              'level': 'wake',
              'seconds': 2550,
            },
            {
              'dateTime': '2022-08-15 06:41:00',
              'level': 'light',
              'seconds': 1560,
            },
            {
              'dateTime': '2022-08-15 07:07:00',
              'level': 'deep',
              'seconds': 210,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-15 01:05:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-15 01:06:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-15 01:09:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-15 01:10:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-15 01:11:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-15 01:12:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-15 01:13:30',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-15 02:01:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-15 02:14:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-15 02:47:00',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-15 03:28:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-15 03:39:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-15 03:58:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-15 05:47:00',
              'level': 'wake',
              'seconds': 90,
            },
          ]
        },
        {
          'score': 36,
          'start': '2022-08-15 16:46',
          'duration': 5550000,
          'data': [
            {
              'dateTime': '2022-08-15 16:48:30',
              'level': 'wake',
              'seconds': 1530,
            },
            {
              'dateTime': '2022-08-15 17:17:00',
              'level': 'deep',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-15 17:29:30',
              'level': 'deep',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-15 17:37:00',
              'level': 'light',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-15 17:50:00',
              'level': 'light',
              'seconds': 750,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-15 16:46:30',
              'level': 'wake',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-15 16:47:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-15 17:14:00',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-15 17:47:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-15 18:02:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-15 18:04:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-15 18:05:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-15 18:08:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-15 18:11:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-15 18:13:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-15 18:16:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-15 18:17:30',
              'level': 'wake',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-16',
      'levels': [
        {
          'score': 47,
          'start': '2022-08-16 00:24',
          'duration': 24540000,
          'data': [
            {
              'dateTime': '2022-08-16 00:24:00',
              'level': 'light',
              'seconds': 3150,
            },
            {
              'dateTime': '2022-08-16 01:16:30',
              'level': 'wake',
              'seconds': 330,
            },
            {
              'dateTime': '2022-08-16 01:23:30',
              'level': 'deep',
              'seconds': 720,
            },
            {
              'dateTime': '2022-08-16 01:38:30',
              'level': 'wake',
              'seconds': 2280,
            },
            {
              'dateTime': '2022-08-16 02:16:30',
              'level': 'light',
              'seconds': 1770,
            },
            {
              'dateTime': '2022-08-16 02:48:30',
              'level': 'light',
              'seconds': 1890,
            },
            {
              'dateTime': '2022-08-16 03:21:30',
              'level': 'deep',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-16 03:25:00',
              'level': 'light',
              'seconds': 1290,
            },
            {
              'dateTime': '2022-08-16 03:46:30',
              'level': 'rem',
              'seconds': 3000,
            },
            {
              'dateTime': '2022-08-16 04:36:30',
              'level': 'deep',
              'seconds': 1440,
            },
            {
              'dateTime': '2022-08-16 05:00:30',
              'level': 'light',
              'seconds': 270,
            },
            {
              'dateTime': '2022-08-16 05:05:00',
              'level': 'deep',
              'seconds': 930,
            },
            {
              'dateTime': '2022-08-16 05:21:30',
              'level': 'wake',
              'seconds': 840,
            },
            {
              'dateTime': '2022-08-16 05:39:00',
              'level': 'light',
              'seconds': 2550,
            },
            {
              'dateTime': '2022-08-16 06:21:30',
              'level': 'light',
              'seconds': 1440,
            },
            {
              'dateTime': '2022-08-16 06:45:30',
              'level': 'wake',
              'seconds': 1650,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-16 01:22:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-16 01:35:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-16 02:46:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-16 03:20:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-16 05:20:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-16 05:35:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-16 05:38:30',
              'level': 'wake',
              'seconds': 30,
            },
          ]
        },
        {
          'score': 64,
          'start': '2022-08-16 17:05',
          'duration': 7710000,
          'data': [
            {
              'dateTime': '2022-08-16 17:05:30',
              'level': 'light',
              'seconds': 720,
            },
            {
              'dateTime': '2022-08-16 17:17:30',
              'level': 'wake',
              'seconds': 930,
            },
            {
              'dateTime': '2022-08-16 17:36:30',
              'level': 'light',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-16 17:52:00',
              'level': 'light',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-16 18:12:30',
              'level': 'deep',
              'seconds': 2790,
            },
            {
              'dateTime': '2022-08-16 19:00:00',
              'level': 'wake',
              'seconds': 540,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-16 17:33:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-16 17:34:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-16 17:49:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-16 17:50:30',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-16 17:51:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-16 18:59:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-16 19:09:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-16 19:10:30',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-16 19:13:30',
              'level': 'light',
              'seconds': 30,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-17',
      'levels': [
        {
          'score': 22,
          'start': '2022-08-17 00:43',
          'duration': 24960000,
          'data': [
            {
              'dateTime': '2022-08-17 00:44:30',
              'level': 'light',
              'seconds': 2730,
            },
            {
              'dateTime': '2022-08-17 01:31:30',
              'level': 'light',
              'seconds': 840,
            },
            {
              'dateTime': '2022-08-17 01:50:30',
              'level': 'wake',
              'seconds': 870,
            },
            {
              'dateTime': '2022-08-17 02:06:00',
              'level': 'deep',
              'seconds': 2730,
            },
            {
              'dateTime': '2022-08-17 02:51:30',
              'level': 'light',
              'seconds': 1950,
            },
            {
              'dateTime': '2022-08-17 03:24:30',
              'level': 'deep',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-17 03:29:30',
              'level': 'deep',
              'seconds': 1620,
            },
            {
              'dateTime': '2022-08-17 03:58:00',
              'level': 'deep',
              'seconds': 2940,
            },
            {
              'dateTime': '2022-08-17 04:47:00',
              'level': 'rem',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-17 05:07:30',
              'level': 'deep',
              'seconds': 2760,
            },
            {
              'dateTime': '2022-08-17 05:53:30',
              'level': 'rem',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-17 06:25:30',
              'level': 'deep',
              'seconds': 720,
            },
            {
              'dateTime': '2022-08-17 06:37:30',
              'level': 'rem',
              'seconds': 240,
            },
            {
              'dateTime': '2022-08-17 06:41:30',
              'level': 'light',
              'seconds': 1470,
            },
            {
              'dateTime': '2022-08-17 07:08:00',
              'level': 'light',
              'seconds': 1350,
            },
            {
              'dateTime': '2022-08-17 07:30:30',
              'level': 'rem',
              'seconds': 540,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-17 00:43:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-17 01:30:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-17 01:45:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-17 01:46:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-17 01:47:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-17 01:49:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-17 02:05:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-17 03:24:00',
              'level': 'rem',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-17 03:28:00',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-17 03:56:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-17 07:06:00',
              'level': 'wake',
              'seconds': 120,
            },
          ]
        },
        {
          'score': 14,
          'start': '2022-08-17 15:06',
          'duration': 6930000,
          'data': [
            {
              'dateTime': '2022-08-17 15:06:30',
              'level': 'deep',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-17 15:17:00',
              'level': 'rem',
              'seconds': 1170,
            },
            {
              'dateTime': '2022-08-17 15:38:30',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-17 15:46:00',
              'level': 'wake',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-17 16:01:00',
              'level': 'wake',
              'seconds': 1530,
            },
            {
              'dateTime': '2022-08-17 16:26:30',
              'level': 'light',
              'seconds': 2130,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-17 15:36:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-17 15:58:30',
              'level': 'light',
              'seconds': 150,
            },
          ]
        },
        {
          'score': 89,
          'start': '2022-08-17 22:53',
          'duration': 22020000,
          'data': [
            {
              'dateTime': '2022-08-17 22:53:30',
              'level': 'deep',
              'seconds': 1020,
            },
            {
              'dateTime': '2022-08-17 23:10:30',
              'level': 'rem',
              'seconds': 1290,
            },
            {
              'dateTime': '2022-08-17 23:35:30',
              'level': 'wake',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-18 00:13:00',
              'level': 'deep',
              'seconds': 2160,
            },
            {
              'dateTime': '2022-08-18 00:51:30',
              'level': 'deep',
              'seconds': 1380,
            },
            {
              'dateTime': '2022-08-18 01:16:30',
              'level': 'deep',
              'seconds': 540,
            },
            {
              'dateTime': '2022-08-18 01:25:30',
              'level': 'rem',
              'seconds': 240,
            },
            {
              'dateTime': '2022-08-18 01:29:30',
              'level': 'deep',
              'seconds': 2460,
            },
            {
              'dateTime': '2022-08-18 02:17:30',
              'level': 'wake',
              'seconds': 2280,
            },
            {
              'dateTime': '2022-08-18 02:55:30',
              'level': 'light',
              'seconds': 780,
            },
            {
              'dateTime': '2022-08-18 03:08:30',
              'level': 'wake',
              'seconds': 510,
            },
            {
              'dateTime': '2022-08-18 03:19:00',
              'level': 'deep',
              'seconds': 3090,
            },
            {
              'dateTime': '2022-08-18 04:10:30',
              'level': 'light',
              'seconds': 3000,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-17 23:32:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-17 23:34:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-18 00:11:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-18 00:49:00',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-18 01:14:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-18 02:10:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-18 02:12:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-18 02:13:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-18 02:16:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-18 03:17:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-18 03:18:00',
              'level': 'rem',
              'seconds': 60,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-18',
      'levels': [
        {
          'score': 69,
          'start': '2022-08-18 18:01',
          'duration': 8040000,
          'data': [
            {
              'dateTime': '2022-08-18 18:04:30',
              'level': 'wake',
              'seconds': 3150,
            },
            {
              'dateTime': '2022-08-18 18:57:00',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-18 19:04:30',
              'level': 'wake',
              'seconds': 3060,
            },
            {
              'dateTime': '2022-08-18 19:55:30',
              'level': 'light',
              'seconds': 1170,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-18 18:01:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-18 18:02:30',
              'level': 'light',
              'seconds': 120,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-19',
      'levels': [
        {
          'score': 15,
          'start': '2022-08-19 00:29',
          'duration': 29640000,
          'data': [
            {
              'dateTime': '2022-08-19 00:29:00',
              'level': 'wake',
              'seconds': 3120,
            },
            {
              'dateTime': '2022-08-19 01:22:30',
              'level': 'deep',
              'seconds': 660,
            },
            {
              'dateTime': '2022-08-19 01:33:30',
              'level': 'deep',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-19 01:55:00',
              'level': 'light',
              'seconds': 1380,
            },
            {
              'dateTime': '2022-08-19 02:24:00',
              'level': 'wake',
              'seconds': 2160,
            },
            {
              'dateTime': '2022-08-19 03:04:00',
              'level': 'deep',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-19 03:43:30',
              'level': 'rem',
              'seconds': 480,
            },
            {
              'dateTime': '2022-08-19 03:51:30',
              'level': 'deep',
              'seconds': 2040,
            },
            {
              'dateTime': '2022-08-19 04:25:30',
              'level': 'rem',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-19 04:57:30',
              'level': 'wake',
              'seconds': 2340,
            },
            {
              'dateTime': '2022-08-19 05:38:30',
              'level': 'wake',
              'seconds': 2520,
            },
            {
              'dateTime': '2022-08-19 06:20:30',
              'level': 'light',
              'seconds': 2550,
            },
            {
              'dateTime': '2022-08-19 07:03:00',
              'level': 'wake',
              'seconds': 2190,
            },
            {
              'dateTime': '2022-08-19 07:42:00',
              'level': 'deep',
              'seconds': 2850,
            },
            {
              'dateTime': '2022-08-19 08:29:30',
              'level': 'light',
              'seconds': 810,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-19 01:21:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 01:51:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-19 01:53:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 02:18:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-19 02:20:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 02:22:00',
              'level': 'rem',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-19 02:22:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 03:00:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-19 03:02:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-19 03:03:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-19 03:39:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 03:41:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-19 04:54:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 04:55:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-19 05:36:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-19 07:39:30',
              'level': 'light',
              'seconds': 150,
            },
          ]
        },
        {
          'score': 23,
          'start': '2022-08-19 16:55',
          'duration': 10500000,
          'data': [
            {
              'dateTime': '2022-08-19 17:00:30',
              'level': 'light',
              'seconds': 2700,
            },
            {
              'dateTime': '2022-08-19 17:45:30',
              'level': 'wake',
              'seconds': 600,
            },
            {
              'dateTime': '2022-08-19 17:57:30',
              'level': 'wake',
              'seconds': 360,
            },
            {
              'dateTime': '2022-08-19 18:12:30',
              'level': 'light',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-19 18:30:00',
              'level': 'deep',
              'seconds': 2640,
            },
            {
              'dateTime': '2022-08-19 19:16:00',
              'level': 'wake',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-19 19:28:30',
              'level': 'light',
              'seconds': 1320,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-19 16:55:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 16:57:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 16:58:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-19 17:55:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-19 18:03:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-19 18:06:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-19 18:08:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-19 18:10:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-19 19:14:00',
              'level': 'light',
              'seconds': 120,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-20',
      'levels': [
        {
          'score': 78,
          'start': '2022-08-20 01:08',
          'duration': 31170000,
          'data': [
            {
              'dateTime': '2022-08-20 01:08:00',
              'level': 'wake',
              'seconds': 1290,
            },
            {
              'dateTime': '2022-08-20 01:34:00',
              'level': 'light',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-20 02:08:30',
              'level': 'light',
              'seconds': 1830,
            },
            {
              'dateTime': '2022-08-20 02:42:30',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-20 02:51:00',
              'level': 'light',
              'seconds': 2820,
            },
            {
              'dateTime': '2022-08-20 03:38:00',
              'level': 'wake',
              'seconds': 2310,
            },
            {
              'dateTime': '2022-08-20 04:22:30',
              'level': 'wake',
              'seconds': 720,
            },
            {
              'dateTime': '2022-08-20 04:35:30',
              'level': 'deep',
              'seconds': 540,
            },
            {
              'dateTime': '2022-08-20 04:44:30',
              'level': 'light',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-20 05:13:00',
              'level': 'wake',
              'seconds': 1140,
            },
            {
              'dateTime': '2022-08-20 05:35:30',
              'level': 'light',
              'seconds': 1530,
            },
            {
              'dateTime': '2022-08-20 06:02:30',
              'level': 'rem',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-20 06:23:00',
              'level': 'deep',
              'seconds': 1170,
            },
            {
              'dateTime': '2022-08-20 06:48:30',
              'level': 'light',
              'seconds': 2340,
            },
            {
              'dateTime': '2022-08-20 07:31:00',
              'level': 'deep',
              'seconds': 1980,
            },
            {
              'dateTime': '2022-08-20 08:04:00',
              'level': 'rem',
              'seconds': 1980,
            },
            {
              'dateTime': '2022-08-20 08:37:00',
              'level': 'deep',
              'seconds': 420,
            },
            {
              'dateTime': '2022-08-20 08:44:00',
              'level': 'light',
              'seconds': 3060,
            },
            {
              'dateTime': '2022-08-20 09:38:00',
              'level': 'light',
              'seconds': 570,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-20 01:29:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-20 01:31:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-20 02:06:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-20 02:39:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-20 02:41:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-20 02:50:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-20 04:16:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-20 04:18:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-20 04:20:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-20 04:34:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-20 05:32:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-20 05:34:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-20 06:01:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-20 06:42:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-20 06:45:30',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-20 07:27:30',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-20 07:28:30',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-20 09:35:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-20 09:36:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-20 09:38:00',
              'level': 'deep',
              'seconds': 0,
            },
          ]
        },
        {
          'score': 78,
          'start': '2022-08-20 20:23',
          'duration': 14550000,
          'data': [
            {
              'dateTime': '2022-08-20 20:23:00',
              'level': 'wake',
              'seconds': 2880,
            },
            {
              'dateTime': '2022-08-20 21:13:00',
              'level': 'wake',
              'seconds': 1470,
            },
            {
              'dateTime': '2022-08-20 21:37:30',
              'level': 'light',
              'seconds': 2460,
            },
            {
              'dateTime': '2022-08-20 22:18:30',
              'level': 'deep',
              'seconds': 1110,
            },
            {
              'dateTime': '2022-08-20 22:37:00',
              'level': 'wake',
              'seconds': 990,
            },
            {
              'dateTime': '2022-08-20 22:53:30',
              'level': 'light',
              'seconds': 1440,
            },
            {
              'dateTime': '2022-08-20 23:17:30',
              'level': 'deep',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-20 23:31:00',
              'level': 'rem',
              'seconds': 2940,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-20 21:11:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-20 23:30:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-21 00:20:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 00:22:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 00:24:00',
              'level': 'deep',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-21',
      'levels': [
        {
          'score': 41,
          'start': '2022-08-21 14:12',
          'duration': 6660000,
          'data': [
            {
              'dateTime': '2022-08-21 14:12:00',
              'level': 'light',
              'seconds': 1530,
            },
            {
              'dateTime': '2022-08-21 14:37:30',
              'level': 'wake',
              'seconds': 1080,
            },
            {
              'dateTime': '2022-08-21 14:57:30',
              'level': 'deep',
              'seconds': 3150,
            },
            {
              'dateTime': '2022-08-21 15:51:00',
              'level': 'deep',
              'seconds': 720,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-21 14:55:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 15:50:00',
              'level': 'light',
              'seconds': 60,
            },
          ]
        },
        {
          'score': 66,
          'start': '2022-08-21 19:29',
          'duration': 10560000,
          'data': [
            {
              'dateTime': '2022-08-21 19:29:30',
              'level': 'light',
              'seconds': 1260,
            },
            {
              'dateTime': '2022-08-21 20:01:00',
              'level': 'light',
              'seconds': 1530,
            },
            {
              'dateTime': '2022-08-21 20:28:00',
              'level': 'light',
              'seconds': 2040,
            },
            {
              'dateTime': '2022-08-21 21:06:00',
              'level': 'deep',
              'seconds': 2190,
            },
            {
              'dateTime': '2022-08-21 21:42:30',
              'level': 'rem',
              'seconds': 480,
            },
            {
              'dateTime': '2022-08-21 21:50:30',
              'level': 'deep',
              'seconds': 1860,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-21 19:50:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-21 19:52:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-21 19:53:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 19:55:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-21 19:57:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-21 19:58:30',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-21 19:59:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 20:26:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-21 21:02:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 21:04:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 22:21:30',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-21 22:23:30',
              'level': 'deep',
              'seconds': 120,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-22',
      'levels': [
        {
          'score': 22,
          'start': '2022-08-22 16:46',
          'duration': 6720000,
          'data': [
            {
              'dateTime': '2022-08-22 16:46:30',
              'level': 'light',
              'seconds': 2940,
            },
            {
              'dateTime': '2022-08-22 17:35:30',
              'level': 'wake',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-22 18:06:00',
              'level': 'light',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-22 18:19:00',
              'level': 'light',
              'seconds': 1170,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-22 18:04:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-22 18:16:30',
              'level': 'wake',
              'seconds': 150,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-23',
      'levels': [
        {
          'score': 2,
          'start': '2022-08-23 00:08',
          'duration': 30660000,
          'data': [
            {
              'dateTime': '2022-08-23 00:17:00',
              'level': 'light',
              'seconds': 2460,
            },
            {
              'dateTime': '2022-08-23 01:00:00',
              'level': 'wake',
              'seconds': 1680,
            },
            {
              'dateTime': '2022-08-23 01:31:30',
              'level': 'light',
              'seconds': 1320,
            },
            {
              'dateTime': '2022-08-23 01:55:30',
              'level': 'light',
              'seconds': 1650,
            },
            {
              'dateTime': '2022-08-23 02:34:00',
              'level': 'deep',
              'seconds': 1200,
            },
            {
              'dateTime': '2022-08-23 02:54:00',
              'level': 'wake',
              'seconds': 1590,
            },
            {
              'dateTime': '2022-08-23 03:20:30',
              'level': 'light',
              'seconds': 2970,
            },
            {
              'dateTime': '2022-08-23 04:10:00',
              'level': 'wake',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-23 04:20:30',
              'level': 'light',
              'seconds': 1560,
            },
            {
              'dateTime': '2022-08-23 04:49:00',
              'level': 'wake',
              'seconds': 3000,
            },
            {
              'dateTime': '2022-08-23 05:40:30',
              'level': 'deep',
              'seconds': 840,
            },
            {
              'dateTime': '2022-08-23 05:54:30',
              'level': 'rem',
              'seconds': 210,
            },
            {
              'dateTime': '2022-08-23 05:58:00',
              'level': 'light',
              'seconds': 600,
            },
            {
              'dateTime': '2022-08-23 06:10:30',
              'level': 'rem',
              'seconds': 1380,
            },
            {
              'dateTime': '2022-08-23 06:38:00',
              'level': 'deep',
              'seconds': 1890,
            },
            {
              'dateTime': '2022-08-23 07:11:30',
              'level': 'deep',
              'seconds': 1590,
            },
            {
              'dateTime': '2022-08-23 07:50:30',
              'level': 'deep',
              'seconds': 2910,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-23 00:08:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-23 00:10:00',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-23 00:10:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 00:12:00',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-23 00:13:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 00:14:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 00:16:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-23 00:58:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 00:59:30',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-23 01:28:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-23 01:30:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 01:53:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-23 02:23:00',
              'level': 'wake',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-23 02:23:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-23 02:26:30',
              'level': 'deep',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-23 02:29:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 02:31:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 02:32:30',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 04:46:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-23 05:39:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 06:08:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 06:09:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-23 06:33:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-23 06:35:30',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-23 07:09:30',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-23 07:10:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 07:38:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-23 07:40:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-23 07:41:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-23 07:42:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-23 07:44:00',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-23 07:46:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-23 07:49:00',
              'level': 'rem',
              'seconds': 90,
            },
          ]
        },
        {
          'score': 80,
          'start': '2022-08-23 15:57',
          'duration': 7830000,
          'data': [
            {
              'dateTime': '2022-08-23 15:57:30',
              'level': 'rem',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-23 16:33:00',
              'level': 'deep',
              'seconds': 1830,
            },
            {
              'dateTime': '2022-08-23 17:03:30',
              'level': 'light',
              'seconds': 2730,
            },
            {
              'dateTime': '2022-08-23 17:55:30',
              'level': 'rem',
              'seconds': 750,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-23 17:49:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-23 17:50:00',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-23 17:52:30',
              'level': 'deep',
              'seconds': 180,
            },
          ]
        },
        {
          'score': 14,
          'start': '2022-08-23 23:43',
          'duration': 27120000,
          'data': [
            {
              'dateTime': '2022-08-23 23:49:30',
              'level': 'light',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-24 00:22:00',
              'level': 'deep',
              'seconds': 2190,
            },
            {
              'dateTime': '2022-08-24 00:58:30',
              'level': 'deep',
              'seconds': 1290,
            },
            {
              'dateTime': '2022-08-24 01:21:30',
              'level': 'deep',
              'seconds': 510,
            },
            {
              'dateTime': '2022-08-24 01:30:00',
              'level': 'light',
              'seconds': 1320,
            },
            {
              'dateTime': '2022-08-24 01:53:30',
              'level': 'rem',
              'seconds': 270,
            },
            {
              'dateTime': '2022-08-24 02:03:00',
              'level': 'deep',
              'seconds': 750,
            },
            {
              'dateTime': '2022-08-24 02:15:30',
              'level': 'light',
              'seconds': 2790,
            },
            {
              'dateTime': '2022-08-24 03:05:30',
              'level': 'deep',
              'seconds': 1500,
            },
            {
              'dateTime': '2022-08-24 03:30:30',
              'level': 'light',
              'seconds': 2190,
            },
            {
              'dateTime': '2022-08-24 04:07:30',
              'level': 'light',
              'seconds': 1860,
            },
            {
              'dateTime': '2022-08-24 04:38:30',
              'level': 'deep',
              'seconds': 2880,
            },
            {
              'dateTime': '2022-08-24 05:26:30',
              'level': 'light',
              'seconds': 2550,
            },
            {
              'dateTime': '2022-08-24 06:12:00',
              'level': 'light',
              'seconds': 1080,
            },
            {
              'dateTime': '2022-08-24 06:30:00',
              'level': 'wake',
              'seconds': 1380,
            },
            {
              'dateTime': '2022-08-24 07:03:30',
              'level': 'wake',
              'seconds': 720,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-23 23:43:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-23 23:46:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-23 23:48:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 00:18:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-24 00:20:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 01:20:00',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 01:52:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 01:58:00',
              'level': 'deep',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-24 02:01:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-24 03:02:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-24 03:04:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 04:07:00',
              'level': 'wake',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-24 06:09:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 06:10:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 06:53:00',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-24 06:55:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-24 06:58:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-24 07:00:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-24 07:02:00',
              'level': 'light',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-24',
      'levels': [
        {
          'score': 80,
          'start': '2022-08-24 16:30',
          'duration': 6810000,
          'data': [
            {
              'dateTime': '2022-08-24 16:35:30',
              'level': 'light',
              'seconds': 3090,
            },
            {
              'dateTime': '2022-08-24 17:31:00',
              'level': 'wake',
              'seconds': 1620,
            },
            {
              'dateTime': '2022-08-24 17:58:00',
              'level': 'light',
              'seconds': 930,
            },
            {
              'dateTime': '2022-08-24 18:13:30',
              'level': 'wake',
              'seconds': 600,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-24 16:30:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-24 16:32:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-24 16:33:30',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-24 17:27:00',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-24 17:29:00',
              'level': 'light',
              'seconds': 120,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-25',
      'levels': [
        {
          'score': 31,
          'start': '2022-08-25 00:37',
          'duration': 25560000,
          'data': [
            {
              'dateTime': '2022-08-25 00:39:00',
              'level': 'light',
              'seconds': 1200,
            },
            {
              'dateTime': '2022-08-25 00:59:00',
              'level': 'deep',
              'seconds': 2520,
            },
            {
              'dateTime': '2022-08-25 01:41:30',
              'level': 'wake',
              'seconds': 360,
            },
            {
              'dateTime': '2022-08-25 01:47:30',
              'level': 'light',
              'seconds': 2610,
            },
            {
              'dateTime': '2022-08-25 02:32:30',
              'level': 'light',
              'seconds': 270,
            },
            {
              'dateTime': '2022-08-25 02:41:30',
              'level': 'deep',
              'seconds': 1380,
            },
            {
              'dateTime': '2022-08-25 03:04:30',
              'level': 'light',
              'seconds': 3000,
            },
            {
              'dateTime': '2022-08-25 03:56:00',
              'level': 'rem',
              'seconds': 930,
            },
            {
              'dateTime': '2022-08-25 04:14:00',
              'level': 'light',
              'seconds': 2520,
            },
            {
              'dateTime': '2022-08-25 04:56:00',
              'level': 'rem',
              'seconds': 1770,
            },
            {
              'dateTime': '2022-08-25 05:33:00',
              'level': 'deep',
              'seconds': 990,
            },
            {
              'dateTime': '2022-08-25 05:49:30',
              'level': 'rem',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-25 06:25:00',
              'level': 'deep',
              'seconds': 2490,
            },
            {
              'dateTime': '2022-08-25 07:08:00',
              'level': 'wake',
              'seconds': 2100,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-25 00:37:00',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-25 00:37:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-25 01:41:00',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-25 02:31:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-25 02:37:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-25 02:38:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-25 03:54:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-25 04:11:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-25 05:25:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-25 05:27:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-25 05:29:00',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-25 05:30:30',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-25 07:06:30',
              'level': 'light',
              'seconds': 90,
            },
          ]
        },
        {
          'score': 69,
          'start': '2022-08-25 14:42',
          'duration': 5940000,
          'data': [
            {
              'dateTime': '2022-08-25 14:42:30',
              'level': 'light',
              'seconds': 510,
            },
            {
              'dateTime': '2022-08-25 14:56:30',
              'level': 'rem',
              'seconds': 2970,
            },
            {
              'dateTime': '2022-08-25 15:46:00',
              'level': 'deep',
              'seconds': 2130,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-25 14:51:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-25 14:53:00',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-25 14:54:30',
              'level': 'deep',
              'seconds': 120,
            },
          ]
        },
        {
          'score': 89,
          'start': '2022-08-25 19:47',
          'duration': 2010000,
          'data': [
            {
              'dateTime': '2022-08-25 19:50:30',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-25 19:58:00',
              'level': 'deep',
              'seconds': 300,
            },
            {
              'dateTime': '2022-08-25 20:03:00',
              'level': 'light',
              'seconds': 300,
            },
            {
              'dateTime': '2022-08-25 20:16:00',
              'level': 'wake',
              'seconds': 300,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-25 19:47:30',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-25 19:48:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-25 20:08:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-25 20:09:00',
              'level': 'rem',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-25 20:10:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-25 20:11:00',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-25 20:11:30',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-25 20:14:30',
              'level': 'light',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-26',
      'levels': [
        {
          'score': 74,
          'start': '2022-08-26 01:28',
          'duration': 18150000,
          'data': [
            {
              'dateTime': '2022-08-26 01:32:30',
              'level': 'light',
              'seconds': 2850,
            },
            {
              'dateTime': '2022-08-26 02:22:00',
              'level': 'light',
              'seconds': 420,
            },
            {
              'dateTime': '2022-08-26 02:29:30',
              'level': 'light',
              'seconds': 1920,
            },
            {
              'dateTime': '2022-08-26 03:10:00',
              'level': 'light',
              'seconds': 1950,
            },
            {
              'dateTime': '2022-08-26 03:45:30',
              'level': 'wake',
              'seconds': 2250,
            },
            {
              'dateTime': '2022-08-26 04:23:00',
              'level': 'light',
              'seconds': 2490,
            },
            {
              'dateTime': '2022-08-26 05:04:30',
              'level': 'rem',
              'seconds': 2280,
            },
            {
              'dateTime': '2022-08-26 05:42:30',
              'level': 'deep',
              'seconds': 2910,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-26 01:28:30',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-26 01:31:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-26 02:20:00',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-26 02:29:00',
              'level': 'wake',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-26 03:01:30',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-26 03:02:30',
              'level': 'light',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-26 03:05:00',
              'level': 'wake',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-26 03:06:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-26 03:07:30',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-26 03:42:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-26 03:44:00',
              'level': 'light',
              'seconds': 90,
            },
          ]
        },
        {
          'score': 69,
          'start': '2022-08-26 15:02',
          'duration': 10020000,
          'data': [
            {
              'dateTime': '2022-08-26 15:02:00',
              'level': 'light',
              'seconds': 1350,
            },
            {
              'dateTime': '2022-08-26 15:26:30',
              'level': 'light',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-26 15:47:00',
              'level': 'deep',
              'seconds': 1350,
            },
            {
              'dateTime': '2022-08-26 16:09:30',
              'level': 'light',
              'seconds': 2100,
            },
            {
              'dateTime': '2022-08-26 16:44:30',
              'level': 'deep',
              'seconds': 1410,
            },
            {
              'dateTime': '2022-08-26 17:09:30',
              'level': 'wake',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-26 17:17:00',
              'level': 'light',
              'seconds': 1050,
            },
            {
              'dateTime': '2022-08-26 17:34:30',
              'level': 'wake',
              'seconds': 870,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-26 15:24:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-26 17:08:00',
              'level': 'light',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-27',
      'levels': [
        {
          'score': 5,
          'start': '2022-08-27 00:03',
          'duration': 25920000,
          'data': [
            {
              'dateTime': '2022-08-27 00:03:30',
              'level': 'light',
              'seconds': 330,
            },
            {
              'dateTime': '2022-08-27 00:09:00',
              'level': 'rem',
              'seconds': 660,
            },
            {
              'dateTime': '2022-08-27 00:20:00',
              'level': 'deep',
              'seconds': 2100,
            },
            {
              'dateTime': '2022-08-27 00:59:30',
              'level': 'light',
              'seconds': 2250,
            },
            {
              'dateTime': '2022-08-27 01:40:30',
              'level': 'wake',
              'seconds': 1590,
            },
            {
              'dateTime': '2022-08-27 02:07:00',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-27 02:16:30',
              'level': 'light',
              'seconds': 1800,
            },
            {
              'dateTime': '2022-08-27 02:48:00',
              'level': 'light',
              'seconds': 330,
            },
            {
              'dateTime': '2022-08-27 02:55:00',
              'level': 'rem',
              'seconds': 2520,
            },
            {
              'dateTime': '2022-08-27 03:37:00',
              'level': 'deep',
              'seconds': 1590,
            },
            {
              'dateTime': '2022-08-27 04:05:30',
              'level': 'deep',
              'seconds': 690,
            },
            {
              'dateTime': '2022-08-27 04:19:00',
              'level': 'deep',
              'seconds': 540,
            },
            {
              'dateTime': '2022-08-27 04:30:00',
              'level': 'wake',
              'seconds': 1080,
            },
            {
              'dateTime': '2022-08-27 04:48:00',
              'level': 'light',
              'seconds': 450,
            },
            {
              'dateTime': '2022-08-27 04:55:30',
              'level': 'wake',
              'seconds': 2670,
            },
            {
              'dateTime': '2022-08-27 05:40:00',
              'level': 'light',
              'seconds': 930,
            },
            {
              'dateTime': '2022-08-27 05:55:30',
              'level': 'deep',
              'seconds': 330,
            },
            {
              'dateTime': '2022-08-27 06:04:00',
              'level': 'deep',
              'seconds': 1140,
            },
            {
              'dateTime': '2022-08-27 06:26:00',
              'level': 'light',
              'seconds': 1170,
            },
            {
              'dateTime': '2022-08-27 06:51:30',
              'level': 'rem',
              'seconds': 870,
            },
            {
              'dateTime': '2022-08-27 07:06:00',
              'level': 'deep',
              'seconds': 570,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-27 00:55:00',
              'level': 'light',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-27 00:58:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-27 01:37:00',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-27 01:39:30',
              'level': 'light',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-27 02:14:30',
              'level': 'wake',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-27 02:46:30',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-27 02:53:30',
              'level': 'deep',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-27 04:03:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-27 04:17:00',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-27 04:28:00',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-27 06:01:00',
              'level': 'rem',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-27 06:23:00',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-27 06:45:30',
              'level': 'deep',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-27 06:47:30',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-27 06:49:00',
              'level': 'deep',
              'seconds': 150,
            },
          ]
        },
        {
          'score': 34,
          'start': '2022-08-27 18:19',
          'duration': 9690000,
          'data': [
            {
              'dateTime': '2022-08-27 18:19:00',
              'level': 'deep',
              'seconds': 1710,
            },
            {
              'dateTime': '2022-08-27 18:47:30',
              'level': 'light',
              'seconds': 240,
            },
            {
              'dateTime': '2022-08-27 18:59:30',
              'level': 'light',
              'seconds': 780,
            },
            {
              'dateTime': '2022-08-27 19:12:30',
              'level': 'wake',
              'seconds': 1410,
            },
            {
              'dateTime': '2022-08-27 19:36:00',
              'level': 'light',
              'seconds': 2160,
            },
            {
              'dateTime': '2022-08-27 20:13:00',
              'level': 'light',
              'seconds': 1590,
            },
            {
              'dateTime': '2022-08-27 20:41:00',
              'level': 'light',
              'seconds': 1170,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-27 18:51:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-27 18:54:00',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-27 18:55:30',
              'level': 'wake',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-27 18:58:00',
              'level': 'light',
              'seconds': 0,
            },
            {
              'dateTime': '2022-08-27 18:58:00',
              'level': 'wake',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-27 20:12:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-27 20:39:30',
              'level': 'wake',
              'seconds': 90,
            },
          ]
        },
      ]
    },
    {
      'dateOfSleep': '2022-08-28',
      'levels': [
        {
          'score': 46,
          'start': '2022-08-28 01:21',
          'duration': 24900000,
          'data': [
            {
              'dateTime': '2022-08-28 01:21:00',
              'level': 'wake',
              'seconds': 1230,
            },
            {
              'dateTime': '2022-08-28 01:46:00',
              'level': 'light',
              'seconds': 810,
            },
            {
              'dateTime': '2022-08-28 01:59:30',
              'level': 'deep',
              'seconds': 360,
            },
            {
              'dateTime': '2022-08-28 02:05:30',
              'level': 'light',
              'seconds': 2460,
            },
            {
              'dateTime': '2022-08-28 02:46:30',
              'level': 'wake',
              'seconds': 2670,
            },
            {
              'dateTime': '2022-08-28 03:34:30',
              'level': 'deep',
              'seconds': 2580,
            },
            {
              'dateTime': '2022-08-28 04:17:30',
              'level': 'rem',
              'seconds': 2130,
            },
            {
              'dateTime': '2022-08-28 04:54:00',
              'level': 'light',
              'seconds': 1500,
            },
            {
              'dateTime': '2022-08-28 05:33:00',
              'level': 'deep',
              'seconds': 510,
            },
            {
              'dateTime': '2022-08-28 05:41:30',
              'level': 'light',
              'seconds': 1950,
            },
            {
              'dateTime': '2022-08-28 06:14:00',
              'level': 'wake',
              'seconds': 810,
            },
            {
              'dateTime': '2022-08-28 06:27:30',
              'level': 'light',
              'seconds': 1770,
            },
            {
              'dateTime': '2022-08-28 06:59:00',
              'level': 'light',
              'seconds': 270,
            },
            {
              'dateTime': '2022-08-28 07:03:30',
              'level': 'wake',
              'seconds': 630,
            },
            {
              'dateTime': '2022-08-28 07:14:00',
              'level': 'light',
              'seconds': 2220,
            },
            {
              'dateTime': '2022-08-28 07:51:00',
              'level': 'deep',
              'seconds': 1500,
            },
          ],
          'shortData': [
            {
              'dateTime': '2022-08-28 01:41:30',
              'level': 'light',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-28 01:43:00',
              'level': 'wake',
              'seconds': 180,
            },
            {
              'dateTime': '2022-08-28 03:31:00',
              'level': 'light',
              'seconds': 30,
            },
            {
              'dateTime': '2022-08-28 03:31:30',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-28 03:32:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-28 04:53:00',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-28 05:19:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-28 05:21:30',
              'level': 'light',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-28 05:23:30',
              'level': 'rem',
              'seconds': 120,
            },
            {
              'dateTime': '2022-08-28 05:25:30',
              'level': 'deep',
              'seconds': 60,
            },
            {
              'dateTime': '2022-08-28 05:26:30',
              'level': 'rem',
              'seconds': 90,
            },
            {
              'dateTime': '2022-08-28 05:28:00',
              'level': 'deep',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-28 05:30:30',
              'level': 'rem',
              'seconds': 150,
            },
            {
              'dateTime': '2022-08-28 06:57:00',
              'level': 'wake',
              'seconds': 120,
            },
          ]
        },
      ]
    },
  ]
};
