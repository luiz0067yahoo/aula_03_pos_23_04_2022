class ClassAcademySubjectStudent {
  static const tableName = 'class_academy_subject_student';
  static const fieldId = 'id';
  static const fieldIdClassAcademy = 'id_class_academy';
  static const fieldNameClassAcademy = 'name_class_academy';
  static const fieldIdSubject = 'id_subject';
  static const fieldNameSubject = 'name_subject';
  static const fieldIdStudent = 'id_student';
  static const fieldNameStudent = 'name_student';
  int? id;
  int? idClassAcademy;
  int? idSubject;
  int? idStudent;
  String? nameClassAcademy;
  String? nameSubject;
  String? nameStudent;

  ClassAcademySubjectStudent(
      {this.id,
      this.idClassAcademy,
      this.idSubject,
      this.idStudent,
      this.nameClassAcademy,
      this.nameSubject,
      this.nameStudent});

  factory ClassAcademySubjectStudent.fromMap(Map map) {
    print(map);
    return ClassAcademySubjectStudent(
      id: int.tryParse(map[ClassAcademySubjectStudent.fieldId].toString()),
      idClassAcademy: int.tryParse(
          map[ClassAcademySubjectStudent.fieldIdClassAcademy].toString()),
      idSubject: int.tryParse(
          map[ClassAcademySubjectStudent.fieldIdSubject].toString()),
      idStudent: int.tryParse(
          map[ClassAcademySubjectStudent.fieldIdStudent].toString()),
      nameClassAcademy: map[ClassAcademySubjectStudent.fieldNameClassAcademy],
      nameSubject: map[ClassAcademySubjectStudent.fieldNameSubject],
      nameStudent: map[ClassAcademySubjectStudent.fieldNameStudent],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ClassAcademySubjectStudent.fieldId: id,
      ClassAcademySubjectStudent.fieldIdClassAcademy: idClassAcademy,
      ClassAcademySubjectStudent.fieldIdSubject: idSubject,
      ClassAcademySubjectStudent.fieldIdStudent: idStudent,
      ClassAcademySubjectStudent.fieldNameClassAcademy: nameClassAcademy,
      ClassAcademySubjectStudent.fieldNameSubject: nameSubject,
      ClassAcademySubjectStudent.fieldNameStudent: nameStudent,
    };
  }
}
//