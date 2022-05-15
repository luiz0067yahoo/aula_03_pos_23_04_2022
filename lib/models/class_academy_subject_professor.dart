class ClassAcademySubjectProfessor {
  static const tableName = 'class_academy_subject_professor';
  static const filedId = 'id';
  static const filedIdClassAcademy = 'id_class_academy';
  static const filedIdSubject = 'id_subject';
  static const filedIdProfessor = 'id_professor';
  int? id;
  int? idClassAcademy;
  int? idSubject;
  int? idProfessor;

  ClassAcademySubjectProfessor(
      {this.id, this.idClassAcademy, this.idSubject, this.idProfessor});

  factory ClassAcademySubjectProfessor.fromMap(Map map) {
    return ClassAcademySubjectProfessor(
      id: int.tryParse(map[ClassAcademySubjectProfessor.filedId].toString()),
      idClassAcademy: int.tryParse(
          map[ClassAcademySubjectProfessor.filedIdClassAcademy].toString()),
      idSubject: int.tryParse(
          map[ClassAcademySubjectProfessor.filedIdSubject].toString()),
      idProfessor: int.tryParse(
          map[ClassAcademySubjectProfessor.filedIdProfessor].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ClassAcademySubjectProfessor.filedIdClassAcademy: idClassAcademy,
      ClassAcademySubjectProfessor.filedIdSubject: idSubject,
      ClassAcademySubjectProfessor.filedIdProfessor: idProfessor,
    };
  }
}
//