class Student {
  static const tableName = 'student';
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

  Student(
      {this.id,
      required this.name,
      this.surName,
      this.RG,
      this.CPF,
      this.birthDate,
      this.sex});

  factory Student.fromMap(Map map) {
    return Student(
      id: int.tryParse(map[Student.filedId].toString()),
      name: map[Student.filedName],
      surName: map[Student.filedSurName],
      RG: map[Student.filedRG],
      CPF: map[Student.filedCPF],
      birthDate: map[Student.filedBirthDate],
      sex: map[Student.filedSex],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Student.filedId: id,
      Student.filedName: name,
      Student.filedSurName: surName,
      Student.filedRG: RG,
      Student.filedCPF: CPF,
      Student.filedBirthDate: birthDate,
      Student.filedSex: sex,
    };
  }
}
