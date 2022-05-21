class Subject {
  static const tableName = 'subject';
  static const fieldId = 'id';
  static const fieldName = 'name';
  int? id;
  String name;

  Subject({this.id, required this.name});

  factory Subject.fromMap(Map map) {
    return Subject(
        id: int.tryParse(map[Subject.fieldId].toString()),
        name: map[Subject.fieldName]);
  }

  Map<String, dynamic> toMap() {
    return {Subject.fieldId: id, Subject.fieldName: name};
  }
}
