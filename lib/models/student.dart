class Student {
  static const tableName = 'student';
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
      id: int.tryParse(map[Student.fieldId].toString()),
      name: map[Student.fieldName],
      surName: map[Student.fieldSurName],
      RG: map[Student.fieldRG],
      CPF: map[Student.fieldCPF],
      birthDate: map[Student.fieldBirthDate],
      sex: map[Student.fieldSex],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Student.fieldId: id,
      Student.fieldName: name,
      Student.fieldSurName: surName,
      Student.fieldRG: RG,
      Student.fieldCPF: CPF,
      Student.fieldBirthDate: birthDate,
      Student.fieldSex: sex,
    };
  }
}
