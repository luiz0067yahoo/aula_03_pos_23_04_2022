class Phase {
  static const tableName = 'phase';
  static const fieldId = 'id';
  static const fieldName = 'name';
  int? id;
  String name;

  Phase({this.id, required this.name});

  factory Phase.fromMap(Map map) {
    return Phase(
        id: int.tryParse(map[Phase.fieldId].toString()),
        name: map[Phase.fieldName]);
  }

  Map<String, dynamic> toMap() {
    return {Phase.fieldId: id, Phase.fieldName: name};
  }
}
