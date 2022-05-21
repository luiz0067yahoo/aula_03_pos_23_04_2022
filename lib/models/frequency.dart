class Frequency {
  static const tableName = 'frequency';
  static const fieldId = 'id';
  static const fieldIdClassAcademy = 'id_class_academy';
  static const fieldIdSubject = 'id_phase';
  static const fieldIdPhase = 'id_subject';
  static const fieldIdStudent = 'id_student';
  static const fieldValueFrequency = 'value_frequency';

  int? id;
  int? idStudent;
  int? idClassAcademy;
  int? idSubject;
  int? idPhase;
  int? valueFrequency;

  Frequency(
      {this.id,
      this.idStudent,
      this.idClassAcademy,
      this.idSubject,
      this.idPhase,
      this.valueFrequency});

  factory Frequency.fromMap(Map map) {
    return Frequency(
      id: int.tryParse(map[Frequency.fieldId].toString()),
      idStudent: int.tryParse(map[Frequency.fieldIdStudent].toString()),
      idClassAcademy:
          int.tryParse(map[Frequency.fieldIdClassAcademy].toString()),
      idSubject: int.tryParse(map[Frequency.fieldIdSubject].toString()),
      idPhase: int.tryParse(map[Frequency.fieldIdPhase].toString()),
      valueFrequency:
          int.tryParse(map[Frequency.fieldValueFrequency].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Frequency.fieldId: id,
      Frequency.fieldIdStudent: idStudent,
      Frequency.fieldIdClassAcademy: idClassAcademy,
      Frequency.fieldIdSubject: idSubject,
      Frequency.fieldIdPhase: idPhase,
      Frequency.fieldValueFrequency: valueFrequency,
    };
  }
}
