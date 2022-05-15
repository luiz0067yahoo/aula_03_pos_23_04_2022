import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/class_academy_subject_professor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ClassAcademySubjectProfessorHelper {
  static const sqlDropClassAcademySubjectProfessor = '''
    DROP TABLE IF  EXISTS ${ClassAcademySubjectProfessor.tableName} ;
  
  ''';
  static const sqlCreateClassAcademySubjectProfessor = '''
    CREATE TABLE IF NOT EXISTS ${ClassAcademySubjectProfessor.tableName} (
      ${ClassAcademySubjectProfessor.filedId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ClassAcademySubjectProfessor.filedIdClassAcademy} INTEGER,
      ${ClassAcademySubjectProfessor.filedIdSubject} INTEGER,
      ${ClassAcademySubjectProfessor.filedIdProfessor} INTEGER
    )
  ''';

  Future<ClassAcademySubjectProfessor> insert(
      ClassAcademySubjectProfessor classAcademySubjectProfessor) async {
    Database db = await ConectDatabase().db;

    await db.insert(ClassAcademySubjectProfessor.tableName,
        classAcademySubjectProfessor.toMap());
    return classAcademySubjectProfessor;
  }

  Future<int> update(
      ClassAcademySubjectProfessor classAcademySubjectProfessor) async {
    Database db = await ConectDatabase().db;

    return db.update(ClassAcademySubjectProfessor.tableName,
        classAcademySubjectProfessor.toMap(),
        where: '${ClassAcademySubjectProfessor.filedId} = ?',
        whereArgs: [classAcademySubjectProfessor.id]);
  }

  Future<int> Delete(
      ClassAcademySubjectProfessor classAcademySubjectProfessor) async {
    Database db = await ConectDatabase().db;

    return db.delete(ClassAcademySubjectProfessor.tableName,
        where: '${ClassAcademySubjectProfessor.filedId} = ?',
        whereArgs: [classAcademySubjectProfessor.id]);
  }

  Future<List<ClassAcademySubjectProfessor>> All() async {
    Database db = await ConectDatabase().db;
    //List dbData = await db.rawQuery('SELECT * FROM editora');
    List dbData = await db.query(ClassAcademySubjectProfessor.tableName);
    return dbData.map((e) => ClassAcademySubjectProfessor.fromMap(e)).toList();
  }

  Future<List<ClassAcademySubjectProfessor>> Find(
    int? searchId,
    int? searchIdClassAcademy,
    int? searchIdSubject,
    int? searchIdProfessor,
  ) async {
    List conditions = [];
    List Args = [];
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectProfessor.filedId} like ?');
      Args.add('%${searchId}%');
    }
    if (searchId != null) {
      conditions
          .add('${ClassAcademySubjectProfessor.filedIdClassAcademy} like ?');
      Args.add('%${searchIdClassAcademy}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectProfessor.filedIdSubject} like ?');
      Args.add('%${searchIdSubject}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectProfessor.filedIdProfessor} like ?');
      Args.add('%${searchIdProfessor}%');
    }

    Database db = await ConectDatabase().db;
    await db.execute(ClassAcademySubjectProfessorHelper
        .sqlCreateClassAcademySubjectProfessor);
    List dbData = await db.query(ClassAcademySubjectProfessor.tableName,
        columns: [
          ClassAcademySubjectProfessor.filedId,
          //ClassAcademySubjectProfessor.filedIdClassAcademy,
          //ClassAcademySubjectProfessor.filedIdSubject,
          //ClassAcademySubjectProfessor.filedIdProfessor,
        ],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => ClassAcademySubjectProfessor.fromMap(e)).toList();
  }

  Future<ClassAcademySubjectProfessor?> getClassAcademySubjectProfessor(
      int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(ClassAcademySubjectProfessor.tableName,
        columns: [
          ClassAcademySubjectProfessor.filedId,
          ClassAcademySubjectProfessor.filedIdClassAcademy,
          ClassAcademySubjectProfessor.filedIdSubject,
          ClassAcademySubjectProfessor.filedIdProfessor,
        ],
        where: '${ClassAcademySubjectProfessor.filedId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return ClassAcademySubjectProfessor.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(await db.rawQuery(
            'SELECT COUNT(*) FROM ${ClassAcademySubjectProfessor.tableName}')) ??
        0;
  }
}
