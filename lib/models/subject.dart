class Subject {
  static const tableName = 'subject';
  static const filedId = 'id';
  static const filedName = 'name';
  int? id;
  String name;

  Subject({this.id, required this.name});

  factory Subject.fromMap(Map map) {
    return Subject(
        id: int.tryParse(map[Subject.filedId].toString()),
        name: map[Subject.filedName]);
  }

  Map<String, dynamic> toMap() {
    return {Subject.filedId: id, Subject.filedName: name};
  }
}
