class Professor {
  static const tableName = 'professor';
  static const filedId = 'id';
  static const filedName = 'name';
  static const filedSurName = 'surname';
  static const filedRG = 'rg';
  static const filedCPF = 'cpf';
  static const filedBirthDate = 'birth_date';
  static const filedSex = 'sex';
  int? id;
  String? name;
  String? surName;
  String? RG;
  String? CPF;
  DateTime? birthDate;
  String? sex;

  Professor(
      {this.id,
      required this.name,
      this.surName,
      this.RG,
      this.CPF,
      this.birthDate,
      this.sex});

  factory Professor.fromMap(Map map) {
    return Professor(
      id: int.tryParse(map[Professor.filedId].toString()),
      name: map[Professor.filedName],
      surName: map[Professor.filedSurName],
      RG: map[Professor.filedRG],
      CPF: map[Professor.filedCPF],
      birthDate: map[Professor.filedBirthDate],
      sex: map[Professor.filedSex],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Professor.filedId: id,
      Professor.filedName: name,
      Professor.filedSurName: surName,
      Professor.filedRG: RG,
      Professor.filedCPF: CPF,
      Professor.filedBirthDate: birthDate,
      Professor.filedSex: sex,
    };
  }
}
