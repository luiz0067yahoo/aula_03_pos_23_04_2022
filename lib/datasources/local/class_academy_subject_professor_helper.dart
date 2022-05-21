import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/class_academy.dart';
import 'package:aula_03_pos/models/class_academy_subject_professor.dart';
import 'package:aula_03_pos/models/professor.dart';
import 'package:aula_03_pos/models/subject.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ClassAcademySubjectProfessorHelper {
  static const sqlDropClassAcademySubjectProfessor = '''
    DROP TABLE IF  EXISTS ${ClassAcademySubjectProfessor.tableName} ;
  
  ''';
  static const sqlCreateClassAcademySubjectProfessor = '''
    CREATE TABLE IF NOT EXISTS ${ClassAcademySubjectProfessor.tableName} (
      ${ClassAcademySubjectProfessor.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ClassAcademySubjectProfessor.fieldIdClassAcademy} INTEGER,
      ${ClassAcademySubjectProfessor.fieldIdSubject} INTEGER,
      ${ClassAcademySubjectProfessor.fieldIdProfessor} INTEGER
    )
  ''';

  Future<ClassAcademySubjectProfessor> insert(
      ClassAcademySubjectProfessor classAcademySubjectProfessor) async {
    Database db = await ConectDatabase().db;

    await db.insert(ClassAcademySubjectProfessor.tableName, {
      ClassAcademySubjectProfessor.fieldIdClassAcademy:
          classAcademySubjectProfessor.idClassAcademy,
      ClassAcademySubjectProfessor.fieldIdSubject:
          classAcademySubjectProfessor.idSubject,
      ClassAcademySubjectProfessor.fieldIdProfessor:
          classAcademySubjectProfessor.idProfessor,
    });
    return classAcademySubjectProfessor;
  }

  Future<int> update(
      ClassAcademySubjectProfessor classAcademySubjectProfessor) async {
    Database db = await ConectDatabase().db;

    return db.update(ClassAcademySubjectProfessor.tableName,
        classAcademySubjectProfessor.toMap(),
        where: '${ClassAcademySubjectProfessor.fieldId} = ?',
        whereArgs: [classAcademySubjectProfessor.id]);
  }

  Future<int> Delete(
      ClassAcademySubjectProfessor classAcademySubjectProfessor) async {
    Database db = await ConectDatabase().db;

    return db.delete(ClassAcademySubjectProfessor.tableName,
        where: '${ClassAcademySubjectProfessor.fieldId} = ?',
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
      conditions.add('${ClassAcademySubjectProfessor.fieldId} like ?');
      Args.add('%${searchId}%');
    }
    if (searchId != null) {
      conditions
          .add('${ClassAcademySubjectProfessor.fieldIdClassAcademy} like ?');
      Args.add('%${searchIdClassAcademy}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectProfessor.fieldIdSubject} like ?');
      Args.add('%${searchIdSubject}%');
    }
    if (searchId != null) {
      conditions.add('${ClassAcademySubjectProfessor.fieldIdProfessor} like ?');
      Args.add('%${searchIdProfessor}%');
    }

    Database db = await ConectDatabase().db;

    List dbData = await db.rawQuery('''
      SELECT  CSP.${ClassAcademySubjectProfessor.fieldId},
              CSP.${ClassAcademySubjectProfessor.fieldIdClassAcademy},
              CSP.${ClassAcademySubjectProfessor.fieldIdSubject},
              CSP.${ClassAcademySubjectProfessor.fieldIdProfessor},
              C.${ClassAcademy.fieldName} AS ${ClassAcademySubjectProfessor.fieldNameClassAcademy},
              S.${Subject.fieldName}  AS ${ClassAcademySubjectProfessor.fieldNameSubject},
              P.${Professor.fieldName} AS   ${ClassAcademySubjectProfessor.fieldNameProfessor}
      FROM ${ClassAcademySubjectProfessor.tableName}  CSP
      LEFT JOIN ${ClassAcademy.tableName} C ON (C.${ClassAcademy.fieldId}=CSP.${ClassAcademySubjectProfessor.fieldIdClassAcademy})
      LEFT JOIN ${Subject.tableName} S ON (S.${Subject.fieldId}=CSP.${ClassAcademySubjectProfessor.fieldIdSubject})
      LEFT JOIN ${Professor.tableName} P ON (P.${Professor.fieldId}=CSP.${ClassAcademySubjectProfessor.fieldIdProfessor})
       ${(conditions.length > 0) ? " WHERE  " + conditions.join(" and ") : ""}
    ''', Args);

    return dbData.map((e) => ClassAcademySubjectProfessor.fromMap(e)).toList();
  }

  Future<ClassAcademySubjectProfessor?> getClassAcademySubjectProfessor(
      int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(ClassAcademySubjectProfessor.tableName,
        columns: [
          ClassAcademySubjectProfessor.fieldId,
          ClassAcademySubjectProfessor.fieldIdClassAcademy,
          ClassAcademySubjectProfessor.fieldIdSubject,
          ClassAcademySubjectProfessor.fieldIdProfessor,
        ],
        where: '${ClassAcademySubjectProfessor.fieldId} = ?',
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
