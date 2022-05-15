class Frequency {
  static const tableName = 'frequency';
  static const filedId = 'id';
  static const filedIdClassAcademy = 'idClassAcademy';
  static const filedIdSubject = 'idPhase';
  static const filedIdPhase = 'idSubject';
  static const filedIdStudent = 'idStudent';
  static const filedValueFrequency = 'value_frequency';

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
      id: int.tryParse(map[Frequency.filedId].toString()),
      idStudent: int.tryParse(map[Frequency.filedIdStudent].toString()),
      idClassAcademy:
          int.tryParse(map[Frequency.filedIdClassAcademy].toString()),
      idSubject: int.tryParse(map[Frequency.filedIdSubject].toString()),
      idPhase: int.tryParse(map[Frequency.filedIdPhase].toString()),
      valueFrequency:
          int.tryParse(map[Frequency.filedValueFrequency].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Frequency.filedId: id,
      Frequency.filedIdStudent: idStudent,
      Frequency.filedIdClassAcademy: idClassAcademy,
      Frequency.filedIdSubject: idSubject,
      Frequency.filedIdPhase: idPhase,
      Frequency.filedValueFrequency: valueFrequency,
    };
  }
}
