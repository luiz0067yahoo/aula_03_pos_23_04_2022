import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class StudentHelper {
  static const sqlCreateStudent = '''
    CREATE TABLE IF NOT EXISTS ${Student.tableName} (
      ${Student.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Student.fieldName} TEXT,
      ${Student.fieldSurName} TEXT,
      ${Student.fieldRG} TEXT,
      ${Student.fieldCPF} TEXT,
      ${Student.fieldBirthDate} DATETIME,
      ${Student.fieldSex} TEXT
    )
  ''';

  Future<Student> insert(Student student) async {
    Database db = await ConectDatabase().db;

    student.id = await db.insert(Student.tableName, student.toMap());
    return student;
  }

  Future<int> update(Student student) async {
    Database db = await ConectDatabase().db;

    return db.update(Student.tableName, student.toMap(),
        where: '${Student.fieldId} = ?', whereArgs: [student.id]);
  }

  Future<int> Delete(Student student) async {
    Database db = await ConectDatabase().db;

    return db.delete(Student.tableName,
        where: '${Student.fieldId} = ?', whereArgs: [student.id]);
  }

  Future<List<Student>> All() async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(
      Student.tableName,
      columns: [
        Student.fieldId,
        Student.fieldName,
        Student.fieldSurName,
        Student.fieldRG,
        Student.fieldCPF,
        Student.fieldBirthDate,
        Student.fieldSex
      ],
    );
    return dbData.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> Find(
      int? searchId,
      String? searchName,
      String? searchSureName,
      String? searchRG,
      String? searchCPF,
      DateTime? searchBirthDate,
      String? searchSex) async {
    List conditions = [];
    List Args = [];
    if ((searchId != null)) {
      conditions.add('${Student.fieldId} like ?');
      Args.add('%${searchId}%');
    }
    if ((searchName != null) && (searchName.length > 0)) {
      conditions.add('upper(${Student.fieldName}) like ?');
      Args.add('%${searchName.toUpperCase()}%');
    }
    if ((searchSureName != null) && (searchSureName.length > 0)) {
      conditions.add('upper(${Student.fieldSurName}) like ?');
      Args.add('%${searchSureName.toUpperCase()}%');
    }
    if ((searchRG != null) && (searchRG.length > 0)) {
      conditions.add('upper(${Student.fieldRG}) like ?');
      Args.add('%${searchRG.toUpperCase()}%');
    }
    if ((searchCPF != null) && (searchCPF.length > 0)) {
      conditions.add('upper(${Student.fieldCPF}) like ?');
      Args.add('%${searchCPF.toUpperCase()}%');
    }
    if ((searchBirthDate != null)) {
      conditions.add('upper(${Student.fieldBirthDate}) like ?');
      Args.add('%${searchBirthDate}%');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(Student.tableName,
        columns: [
          Student.fieldId,
          Student.fieldName,
          Student.fieldSurName,
          Student.fieldRG,
          Student.fieldCPF,
          Student.fieldBirthDate,
          Student.fieldSex
        ],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => Student.fromMap(e)).toList();
  }

  Future<Student?> getStudent(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(Student.tableName,
        columns: [Student.fieldId, Student.fieldName],
        where: '${Student.fieldId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return Student.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM ${Student.tableName}')) ??
        0;
  }
}
