import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/class_academy_subject_student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ClassAcademySubjectStudentHelper {
  static const sqlCreateClassAcademySubjectStudent = '''

    DROP TABLE IF  EXISTS ${ClassAcademySubjectStudent.tableName} ;
    CREATE TABLE IF NOT EXISTS ${ClassAcademySubjectStudent.tableName} (
      ${ClassAcademySubjectStudent.filedId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ClassAcademySubjectStudent.filedIdClassAcademy} INTEGER ,
      ${ClassAcademySubjectStudent.filedIdSubject} INTEGER ,
      ${ClassAcademySubjectStudent.filedIdStudent} INTEGER 
    )
  ''';

  Future<ClassAcademySubjectStudent> insert(
      ClassAcademySubjectStudent classAcademySubjectStudent) async {
    Database db = await ConectDatabase().db;

    await db.insert(ClassAcademySubjectStudent.tableName,
        classAcademySubjectStudent.toMap());
    return classAcademySubjectStudent;
  }

  Future<int> update(
      ClassAcademySubjectStudent classAcademySubjectStudent) async {
    Database db = await ConectDatabase().db;

    return db.update(ClassAcademySubjectStudent.tableName,
        classAcademySubjectStudent.toMap(),
        where: '${ClassAcademySubjectStudent.filedId} = ?',
        whereArgs: [classAcademySubjectStudent.id]);
  }

  Future<int> Delete(
      ClassAcademySubjectStudent classAcademySubjectStudent) async {
    Database db = await ConectDatabase().db;

    return db.delete(ClassAcademySubjectStudent.tableName,
        where: '${ClassAcademySubjectStudent.filedId} = ?',
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
      conditions.add('${ClassAcademySubjectStudent.filedId} like ?');
      Args.add('%${searchId}%');
    }
    if (searchId != null) {
      conditions
          .add('${ClassAcademySubjectStudent.filedIdClassAcademy} like ?');
      Args.add('%${searchIdClassAcademy}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectStudent.filedIdSubject} like ?');
      Args.add('%${searchIdSubject}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectStudent.filedIdStudent} like ?');
      Args.add('%${searchIdStudent}%');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(ClassAcademySubjectStudent.tableName,
        columns: [
          ClassAcademySubjectStudent.filedId,
          ClassAcademySubjectStudent.filedIdClassAcademy,
          ClassAcademySubjectStudent.filedIdSubject,
          ClassAcademySubjectStudent.filedIdStudent,
        ],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => ClassAcademySubjectStudent.fromMap(e)).toList();
  }

  Future<ClassAcademySubjectStudent?> getClassAcademySubjectStudent(
      int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(ClassAcademySubjectStudent.tableName,
        columns: [
          ClassAcademySubjectStudent.filedId,
          ClassAcademySubjectStudent.filedIdClassAcademy,
          ClassAcademySubjectStudent.filedIdSubject,
          ClassAcademySubjectStudent.filedIdStudent,
        ],
        where: '${ClassAcademySubjectStudent.filedId} = ?',
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
