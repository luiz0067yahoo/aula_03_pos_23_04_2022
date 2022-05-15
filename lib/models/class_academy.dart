class ClassAcademy {
  static const tabela = 'classAcademy';
  static const filedId = 'id';
  static const filedName = 'name';
  int? id;
  String name;

  ClassAcademy({this.id, required this.name});

  factory ClassAcademy.fromMap(Map map) {
    return ClassAcademy(
        id: int.tryParse(map[ClassAcademy.filedId].toString()),
        name: map[ClassAcademy.filedName]);
  }

  Map<String, dynamic> toMap() {
    return {ClassAcademy.filedId: id, ClassAcademy.filedName: name};
  }
}
