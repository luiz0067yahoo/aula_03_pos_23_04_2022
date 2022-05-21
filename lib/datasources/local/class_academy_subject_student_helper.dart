import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/class_academy.dart';
import 'package:aula_03_pos/models/class_academy_subject_student.dart';
import 'package:aula_03_pos/models/student.dart';
import 'package:aula_03_pos/models/subject.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ClassAcademySubjectStudentHelper {
  static const sqlDropClassAcademySubjectStudent = '''
    DROP TABLE IF  EXISTS ${ClassAcademySubjectStudent.tableName} ;
  
  ''';
  static const sqlCreateClassAcademySubjectStudent = '''
    CREATE TABLE IF NOT EXISTS ${ClassAcademySubjectStudent.tableName} (
      ${ClassAcademySubjectStudent.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ClassAcademySubjectStudent.fieldIdClassAcademy} INTEGER,
      ${ClassAcademySubjectStudent.fieldIdSubject} INTEGER,
      ${ClassAcademySubjectStudent.fieldIdStudent} INTEGER
    )
  ''';

  Future<ClassAcademySubjectStudent> insert(
      ClassAcademySubjectStudent classAcademySubjectStudent) async {
    Database db = await ConectDatabase().db;

    await db.insert(ClassAcademySubjectStudent.tableName, {
      ClassAcademySubjectStudent.fieldIdClassAcademy:
          classAcademySubjectStudent.idClassAcademy,
      ClassAcademySubjectStudent.fieldIdSubject:
          classAcademySubjectStudent.idSubject,
      ClassAcademySubjectStudent.fieldIdStudent:
          classAcademySubjectStudent.idStudent,
    });
    return classAcademySubjectStudent;
  }

  Future<int> update(
      ClassAcademySubjectStudent classAcademySubjectStudent) async {
    Database db = await ConectDatabase().db;

    return db.update(ClassAcademySubjectStudent.tableName,
        classAcademySubjectStudent.toMap(),
        where: '${ClassAcademySubjectStudent.fieldId} = ?',
        whereArgs: [classAcademySubjectStudent.id]);
  }

  Future<int> Delete(
      ClassAcademySubjectStudent classAcademySubjectStudent) async {
    Database db = await ConectDatabase().db;

    return db.delete(ClassAcademySubjectStudent.tableName,
        where: '${ClassAcademySubjectStudent.fieldId} = ?',
        whereArgs: [classAcademySubjectStudent.id]);
  }

  Future<List<ClassAcademySubjectStudent>> All() async {
    Database db = await ConectDatabase().db;
    //List dbData = await db.rawQuery('SELECT * FROM editora');
    List dbData = await db.query(ClassAcademySubjectStudent.tableName);
    return dbData.map((e) => ClassAcademySubjectStudent.fromMap(e)).toList();
  }

  Future<List<ClassAcademySubjectStudent>> Find(
    int? searchId,
    int? searchIdClassAcademy,
    int? searchIdSubject,
    int? searchIdStudent,
  ) async {
    List conditions = [];
    List Args = [];
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectStudent.fieldId} like ?');
      Args.add('%${searchId}%');
    }
    if (searchId != null) {
      conditions
          .add('${ClassAcademySubjectStudent.fieldIdClassAcademy} like ?');
      Args.add('%${searchIdClassAcademy}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectStudent.fieldIdSubject} like ?');
      Args.add('%${searchIdSubject}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectStudent.fieldIdStudent} like ?');
      Args.add('%${searchIdStudent}%');
    }

    Database db = await ConectDatabase().db;

    List dbData = await db.rawQuery('''
      SELECT  CSP.${ClassAcademySubjectStudent.fieldId},
              CSP.${ClassAcademySubjectStudent.fieldIdClassAcademy},
              CSP.${ClassAcademySubjectStudent.fieldIdSubject},
              CSP.${ClassAcademySubjectStudent.fieldIdStudent},
              C.${ClassAcademy.fieldName} AS ${ClassAcademySubjectStudent.fieldNameClassAcademy},
              S.${Subject.fieldName}  AS ${ClassAcademySubjectStudent.fieldNameSubject},
              P.${Student.fieldName} AS   ${ClassAcademySubjectStudent.fieldNameStudent}
      FROM ${ClassAcademySubjectStudent.tableName}  CSP
      LEFT JOIN ${ClassAcademy.tableName} C ON (C.${ClassAcademy.fieldId}=CSP.${ClassAcademySubjectStudent.fieldIdClassAcademy})
      LEFT JOIN ${Subject.tableName} S ON (S.${Subject.fieldId}=CSP.${ClassAcademySubjectStudent.fieldIdSubject})
      LEFT JOIN ${Student.tableName} P ON (P.${Student.fieldId}=CSP.${ClassAcademySubjectStudent.fieldIdStudent})
       ${(conditions.length > 0) ? " WHERE  " + conditions.join(" and ") : ""}
    ''', Args);

    return dbData.map((e) => ClassAcademySubjectStudent.fromMap(e)).toList();
  }

  Future<ClassAcademySubjectStudent?> getClassAcademySubjectStudent(
      int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(ClassAcademySubjectStudent.tableName,
        columns: [
          ClassAcademySubjectStudent.fieldId,
          ClassAcademySubjectStudent.fieldIdClassAcademy,
          ClassAcademySubjectStudent.fieldIdSubject,
          ClassAcademySubjectStudent.fieldIdStudent,
        ],
        where: '${ClassAcademySubjectStudent.fieldId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return ClassAcademySubjectStudent.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(await db.rawQuery(
            'SELECT COUNT(*) FROM ${ClassAcademySubjectStudent.tableName}')) ??
        0;
  }
}
