class ClassAcademySubjectStudent {
  static const tableName = 'class_academy_suject_student';
  static const filedId = 'id';
  static const filedIdClassAcademy = 'id_class_academy';
  static const filedIdSubject = 'id_subject';
  static const filedIdStudent = 'id_student';
  int? id;
  int? idClassAcademy;
  int? idSubject;
  int? idStudent;

  ClassAcademySubjectStudent(
      {this.id, this.idClassAcademy, this.idSubject, this.idStudent});

  factory ClassAcademySubjectStudent.fromMap(Map map) {
    return ClassAcademySubjectStudent(
      id: int.tryParse(map[ClassAcademySubjectStudent.filedId].toString()),
      idClassAcademy: int.tryParse(
          map[ClassAcademySubjectStudent.filedIdClassAcademy].toString()),
      idSubject: int.tryParse(
          map[ClassAcademySubjectStudent.filedIdSubject].toString()),
      idStudent: int.tryParse(
          map[ClassAcademySubjectStudent.filedIdStudent].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ClassAcademySubjectStudent.filedIdClassAcademy: idClassAcademy,
      ClassAcademySubjectStudent.filedIdSubject: idSubject,
      ClassAcademySubjectStudent.filedIdStudent: idStudent,
    };
  }
}
