class ClassAcademy {
  static const tableName = 'classAcademy';
  static const fieldId = 'id';
  static const fieldName = 'name';
  int? id;
  String name;

  ClassAcademy({this.id, required this.name});

  factory ClassAcademy.fromMap(Map map) {
    return ClassAcademy(
        id: int.tryParse(map[ClassAcademy.fieldId].toString()),
        name: map[ClassAcademy.fieldName]);
  }

  Map<String, dynamic> toMap() {
    return {ClassAcademy.fieldId: id, ClassAcademy.fieldName: name};
  }
}
