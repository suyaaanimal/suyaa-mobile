import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/enum/monster_genesis.dart';

@immutable
class MonsterState {
  const MonsterState({
    required this.genesis,
  });

  final MonsterGenesis genesis;

  MonsterState copyWith({
    MonsterGenesis? genesis,
  }) =>
      MonsterState(
        genesis: genesis ?? this.genesis,
      );
}
