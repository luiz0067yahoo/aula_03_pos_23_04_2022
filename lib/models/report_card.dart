class ReportCard {
  static const fieldIdClassAcademy = 'id_class_academy';
  static const fieldNameClassAcademy = 'name_class_academy';
  static const fieldIdSubject = 'id_subject';
  static const fieldNameSubject = 'name_subject';
  static const fieldIdStudent = 'id_student';
  static const fieldNameStudent = 'name_student';
  static const fieldIdScorre = 'id_scorre';
  static const fieldValueScorre = 'value_scorre';
  static const fieldIdFrequency = 'id_frequency';
  static const fieldValueFrequency = 'value_frequency';
  static const fieldIdPhase = 'id_phase';
  static const fieldNamePhase = 'name_fase';
  int? idClassAcademy;
  int? idSubject;
  int? idStudent;
  int? idSCorre;
  int? idFrequency;
  int? idPhase;
  String? nameSubject;
  String? nameClassAcademy;
  String? nameStudent;
  int? valueScorre;
  int? valueFrequency;
  String? namePhase;

  ReportCard({
    this.idClassAcademy,
    this.idSubject,
    this.idStudent,
    this.idSCorre,
    this.idFrequency,
    this.idPhase,
    this.nameClassAcademy,
    this.nameSubject,
    this.nameStudent,
    this.valueScorre,
    this.valueFrequency,
    this.namePhase,
  });

  factory ReportCard.fromMap(Map map) {
    print(map);
    return ReportCard(
      idClassAcademy:
          int.tryParse(map[ReportCard.fieldIdClassAcademy].toString()),
      idSubject: int.tryParse(map[ReportCard.fieldIdSubject].toString()),
      idStudent: int.tryParse(map[ReportCard.fieldIdStudent].toString()),
      idSCorre: int.tryParse(map[ReportCard.fieldIdScorre].toString()),
      idFrequency: int.tryParse(map[ReportCard.fieldIdFrequency].toString()),
      idPhase: int.tryParse(map[ReportCard.fieldIdPhase].toString()),
      nameClassAcademy: map[ReportCard.fieldNameClassAcademy],
      nameSubject: map[ReportCard.fieldNameSubject],
      nameStudent: map[ReportCard.fieldNameStudent],
      valueScorre: int.tryParse(map[ReportCard.fieldValueScorre].toString()),
      valueFrequency:
          int.tryParse(map[ReportCard.fieldValueFrequency].toString()),
      namePhase: map[ReportCard.fieldNamePhase],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ReportCard.fieldIdClassAcademy: idClassAcademy,
      ReportCard.fieldIdSubject: idSubject,
      ReportCard.fieldIdStudent: idStudent,
      ReportCard.fieldIdScorre: idSCorre,
      ReportCard.fieldIdFrequency: idFrequency,
      ReportCard.fieldIdPhase: idPhase,
      ReportCard.fieldNameClassAcademy: nameClassAcademy,
      ReportCard.fieldNameSubject: nameSubject,
      ReportCard.fieldValueScorre: valueScorre,
      ReportCard.fieldValueFrequency: valueFrequency,
      ReportCard.fieldNamePhase: namePhase,
    };
  }
}
//