class Scorre {
  static const tableName = 'scorre';
  static const filedId = 'id';
  static const filedIdClassAcademy = 'idClassAcademy';
  static const filedIdSubject = 'idPhase';
  static const filedIdPhase = 'idSubject';
  static const filedIdStudent = 'idStudent';
  static const filedValueScorre = 'value_scorre';

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
      id: int.tryParse(map[Scorre.filedId].toString()),
      idStudent: int.tryParse(map[Scorre.filedIdStudent].toString()),
      idClassAcademy: int.tryParse(map[Scorre.filedIdClassAcademy].toString()),
      idSubject: int.tryParse(map[Scorre.filedIdSubject].toString()),
      idPhase: int.tryParse(map[Scorre.filedIdPhase].toString()),
      valueScorre: int.tryParse(map[Scorre.filedValueScorre].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Scorre.filedId: id,
      Scorre.filedIdStudent: idStudent,
      Scorre.filedIdClassAcademy: idClassAcademy,
      Scorre.filedIdSubject: idSubject,
      Scorre.filedIdPhase: idPhase,
      Scorre.filedValueScorre: valueScorre,
    };
  }
}
