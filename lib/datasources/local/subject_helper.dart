import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/subject.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class SubjectHelper {
  static const sqlCreateSubject = '''
    CREATE TABLE IF NOT EXISTS ${Subject.tableName} (
      ${Subject.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Subject.fieldName} TEXT
    );
  ''';

  Future<Subject> insert(Subject subject) async {
    Database db = await ConectDatabase().db;

    subject.id = await db.insert(Subject.tableName, subject.toMap());
    return subject;
  }

  Future<int> update(Subject subject) async {
    Database db = await ConectDatabase().db;

    return db.update(Subject.tableName, subject.toMap(),
        where: '${Subject.fieldId} = ?', whereArgs: [subject.id]);
  }

  Future<int> Delete(Subject subject) async {
    Database db = await ConectDatabase().db;

    return db.delete(Subject.tableName,
        where: '${Subject.fieldId} = ?', whereArgs: [subject.id]);
  }

  Future<List<Subject>> All() async {
    Database db = await ConectDatabase().db;
    //List dbData = await db.rawQuery('SELECT * FROM editora');
    List dbData = await db.query(Subject.tableName);
    return dbData.map((e) => Subject.fromMap(e)).toList();
  }

  Future<List<Subject>> Find(int? searchId, String? searchName) async {
    List conditions = [];
    List Args = [];
    if (searchId != null) {
      conditions.add('${Subject.fieldId} like ?');
      Args.add('%${searchId}%');
    }
    if (searchName != null) {
      conditions.add('upper(${Subject.fieldName}) like ?');
      Args.add('%${searchName.toUpperCase()}%');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(Subject.tableName,
        columns: [Subject.fieldId, Subject.fieldName],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => Subject.fromMap(e)).toList();
  }

  Future<Subject?> getSubject(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(Subject.tableName,
        columns: [Subject.fieldId, Subject.fieldName],
        where: '${Subject.fieldId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return Subject.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM ${Subject.tableName}')) ??
        0;
  }
}
