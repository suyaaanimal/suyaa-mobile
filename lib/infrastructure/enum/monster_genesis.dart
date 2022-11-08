enum MonsterGenesis {
  /// 胚
  embryo('asset/seichou/egg.png'),

  /// 幼生
  larva('asset/seichou/youji.png'),

  /// 亜成体
  subadult('asset/seichou/shouni.png'),

  /// 成体
  adult('asset/seichou/otona.png'),
  ;

  final String assetPath;
  const MonsterGenesis(this.assetPath);
}
