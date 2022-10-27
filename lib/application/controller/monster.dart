import 'package:state_notifier/state_notifier.dart';
import 'package:suyaa_mobile/application/state/monster.dart';
import 'package:suyaa_mobile/infrastructure/enum/monster_genesis.dart';

class Monster extends StateNotifier<MonsterState> {
  Monster() : super(const MonsterState(genesis: MonsterGenesis.adult));
}
