class Phase {
  static const tabela = 'phase';
  static const filedId = 'id';
  static const filedName = 'name';
  int? id;
  String name;

  Phase({this.id, required this.name});

  factory Phase.fromMap(Map map) {
    return Phase(
        id: int.tryParse(map[Phase.filedId].toString()),
        name: map[Phase.filedName]);
  }

  Map<String, dynamic> toMap() {
    return {Phase.filedId: id, Phase.filedName: name};
  }
}
