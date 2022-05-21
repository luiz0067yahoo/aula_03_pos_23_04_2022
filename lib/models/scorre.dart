class Scorre {
  static const tableName = 'scorre';
  static const fieldId = 'id';
  static const fieldIdClassAcademy = 'id_class_academy';
  static const fieldIdSubject = 'id_phase';
  static const fieldIdPhase = 'id_subject';
  static const fieldIdStudent = 'id_student';
  static const fieldValueScorre = 'value_scorre';

  int? id;
  int? idStudent;
  int? idClassAcademy;
  int? idSubject;
  int? idPhase;
  int? valueScorre;

  Scorre(
      {this.id,
      this.idStudent,
      this.idClassAcademy,
      this.idSubject,
      this.idPhase,
      this.valueScorre});

  factory Scorre.fromMap(Map map) {
    return Scorre(
      id: int.tryParse(map[Scorre.fieldId].toString()),
      idStudent: int.tryParse(map[Scorre.fieldIdStudent].toString()),
      idClassAcademy: int.tryParse(map[Scorre.fieldIdClassAcademy].toString()),
      idSubject: int.tryParse(map[Scorre.fieldIdSubject].toString()),
      idPhase: int.tryParse(map[Scorre.fieldIdPhase].toString()),
      valueScorre: int.tryParse(map[Scorre.fieldValueScorre].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Scorre.fieldId: id,
      Scorre.fieldIdStudent: idStudent,
      Scorre.fieldIdClassAcademy: idClassAcademy,
      Scorre.fieldIdSubject: idSubject,
      Scorre.fieldIdPhase: idPhase,
      Scorre.fieldValueScorre: valueScorre,
    };
  }
}
