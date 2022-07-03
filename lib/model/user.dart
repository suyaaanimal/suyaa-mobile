import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rpg_font/const.dart';

class User extends ChangeNotifier {
  String? name;
  String? sessionToken;
  String? walletAddress;
  bool _logined = false;
  bool get logined => _logined;

  Future<bool> signup(
      String name, String password, String walletAddress) async {
    final response = await http.post(
        Uri.parse('http://$domain:3000/auth/signup'),
        body: json.encode({
          'username': name,
          'password': password,
          'wallet_address': walletAddress
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      this.name = name;
      sessionToken = json.decode(response.body)['token'];
      this.walletAddress = walletAddress;
      _logined = true;
      notifyListeners();
      return true;
    } else {
      debugPrint(response.statusCode.toString());
    }
    return false;
  }

  signin(String name, String password) async {
    final response =
        await http.post(Uri.parse('http://$domain:3000/auth/signin'),
            body: json.encode({
              'username': name,
              'password': password,
            }),
            headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      this.name = name;
      sessionToken = json.decode(response.body)['token'];
      _logined = true;
      notifyListeners();
      return true;
    }
    return false;
  }
}
