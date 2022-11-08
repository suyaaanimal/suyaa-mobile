import 'package:flutter/material.dart';

enum HomePagesIndex {
  // timer(
  //   icon: Icon(Icons.timer),
  // ),
  sleepHistory(
    icon: Icon(Icons.night_shelter),
  ),
  home(
    icon: Icon(Icons.home),
  ),
  // itemShop(
  //   icon: Icon(Icons.toys),
  // ),
  settings(
    icon: Icon(Icons.settings),
  ),
  ;

  const HomePagesIndex({
    required this.icon,
  });

  final Widget icon;

  String get path => '/home/$name';
}
