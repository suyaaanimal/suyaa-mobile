import 'package:flutter/material.dart';

class Domain extends ChangeNotifier {
  String _domain = "localhost";
  String _port = "3000";

  String get domain => _domain;
  String get port => _port;

  set domain(String domain) {
    _domain = domain;
    notifyListeners();
  }

  set port(String port) {
    _port = port;
    notifyListeners();
  }
}
