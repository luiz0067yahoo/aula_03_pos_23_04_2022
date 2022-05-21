class ClassAcademySubjectProfessor {
  static const tableName = 'class_academy_subject_professor';
  static const fieldId = 'id';
  static const fieldIdClassAcademy = 'id_class_academy';
  static const fieldNameClassAcademy = 'name_class_academy';
  static const fieldIdSubject = 'id_subject';
  static const fieldNameSubject = 'name_subject';
  static const fieldIdProfessor = 'id_professor';
  static const fieldNameProfessor = 'name_professor';
  int? id;
  int? idClassAcademy;
  int? idSubject;
  int? idProfessor;
  String? nameClassAcademy;
  String? nameSubject;
  String? nameProfessor;

  ClassAcademySubjectProfessor(
      {this.id,
      this.idClassAcademy,
      this.idSubject,
      this.idProfessor,
      this.nameClassAcademy,
      this.nameSubject,
      this.nameProfessor});

  factory ClassAcademySubjectProfessor.fromMap(Map map) {
    print(map);
    return ClassAcademySubjectProfessor(
      id: int.tryParse(map[ClassAcademySubjectProfessor.fieldId].toString()),
      idClassAcademy: int.tryParse(
          map[ClassAcademySubjectProfessor.fieldIdClassAcademy].toString()),
      idSubject: int.tryParse(
          map[ClassAcademySubjectProfessor.fieldIdSubject].toString()),
      idProfessor: int.tryParse(
          map[ClassAcademySubjectProfessor.fieldIdProfessor].toString()),
      nameClassAcademy: map[ClassAcademySubjectProfessor.fieldNameClassAcademy],
      nameSubject: map[ClassAcademySubjectProfessor.fieldNameSubject],
      nameProfessor: map[ClassAcademySubjectProfessor.fieldNameProfessor],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ClassAcademySubjectProfessor.fieldId: id,
      ClassAcademySubjectProfessor.fieldIdClassAcademy: idClassAcademy,
      ClassAcademySubjectProfessor.fieldIdSubject: idSubject,
      ClassAcademySubjectProfessor.fieldIdProfessor: idProfessor,
      ClassAcademySubjectProfessor.fieldNameClassAcademy: nameClassAcademy,
      ClassAcademySubjectProfessor.fieldNameSubject: nameSubject,
      ClassAcademySubjectProfessor.fieldNameProfessor: nameProfessor,
    };
  }
}
//