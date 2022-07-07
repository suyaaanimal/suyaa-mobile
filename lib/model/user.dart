import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String? name;
  String? sessionToken;
  String? walletAddress;
  bool _logined = false;
  bool get logined => _logined;
  String domain;
  String port;

  User(this.domain, this.port);

  updateDomain(domain, port) {
    this.domain = domain;
    this.port = port;
  }

  Future<bool> signup(
      String name, String password, String walletAddress) async {
    final response = await http.post(
        Uri.parse('http://$domain:$port/auth/signup'),
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
        await http.post(Uri.parse('http://$domain:$port/auth/signin'),
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
