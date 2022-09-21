import 'package:flutter/material.dart';

enum HomePagesIndex {
  timer(
    icon: Icon(Icons.timer),
  ),
  home(
    icon: Icon(Icons.home),
  ),
  sleepHistory(
    icon: Icon(Icons.night_shelter),
  ),
  itemShop(
    icon: Icon(Icons.toys),
  ),
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
