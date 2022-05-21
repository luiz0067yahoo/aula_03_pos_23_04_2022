class Professor {
  static const tableName = 'professor';
  static const fieldId = 'id';
  static const fieldName = 'name';
  static const fieldSurName = 'surname';
  static const fieldRG = 'rg';
  static const fieldCPF = 'cpf';
  static const fieldBirthDate = 'birth_date';
  static const fieldSex = 'sex';
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
      id: int.tryParse(map[Professor.fieldId].toString()),
      name: map[Professor.fieldName],
      surName: map[Professor.fieldSurName],
      RG: map[Professor.fieldRG],
      CPF: map[Professor.fieldCPF],
      birthDate: map[Professor.fieldBirthDate],
      sex: map[Professor.fieldSex],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Professor.fieldId: id,
      Professor.fieldName: name,
      Professor.fieldSurName: surName,
      Professor.fieldRG: RG,
      Professor.fieldCPF: CPF,
      Professor.fieldBirthDate: birthDate,
      Professor.fieldSex: sex,
    };
  }
}
