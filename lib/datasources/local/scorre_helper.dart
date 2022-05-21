import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/scorre.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ScorreHelper {
  static const sqlDropScorre = '''

    DROP TABLE IF  EXISTS ${Scorre.tableName} ;s
  ''';
  static const sqlCreateScorre = '''
    CREATE TABLE IF NOT EXISTS ${Scorre.tableName} (
      ${Scorre.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Scorre.fieldIdStudent} INTEGER ,
      ${Scorre.fieldIdSubject} INTEGER ,
      ${Scorre.fieldIdClassAcademy} INTEGER ,
      ${Scorre.fieldIdPhase} INTEGER ,
      ${Scorre.fieldValueScorre} INTEGER 
    )
  ''';

  Future<Scorre> insert(Scorre scorre) async {
    Database db = await ConectDatabase().db;

    scorre.id = await db.insert(Scorre.tableName, scorre.toMap());
    return scorre;
  }

  Future<int> update(Scorre scorre) async {
    Database db = await ConectDatabase().db;

    return db.update(Scorre.tableName, scorre.toMap(),
        where: '${Scorre.fieldId} = ?', whereArgs: [scorre.id]);
  }

  Future<int> Delete(Scorre scorre) async {
    Database db = await ConectDatabase().db;

    return db.delete(Scorre.tableName,
        where: '${Scorre.fieldId} = ?', whereArgs: [scorre.id]);
  }

  Future<List<Scorre>> All() async {
    Database db = await ConectDatabase().db;
    //List dbData = await db.rawQuery('SELECT * FROM editora');
    List dbData = await db.query(Scorre.tableName);
    return dbData.map((e) => Scorre.fromMap(e)).toList();
  }

  Future<List<Scorre>> Find(
      int? searchId,
      int? searchIdStudent,
      int? searchIdClassAcademy,
      int? searchIdSubject,
      int? searchIdPhase,
      int? searchValueScorre) async {
    List conditions = [];
    List Args = [];
    if (searchId != null) {
      conditions.add('${Scorre.fieldId} like ?');
      Args.add('${searchId}');
    }
    if (searchIdStudent != null) {
      conditions.add('${Scorre.fieldIdStudent} like ?');
      Args.add('${searchIdStudent}');
    }
    if (searchIdClassAcademy != null) {
      conditions.add('${Scorre.fieldIdClassAcademy} like ?');
      Args.add('${searchIdClassAcademy}');
    }
    if (searchIdSubject != null) {
      conditions.add('${Scorre.fieldIdStudent} like ?');
      Args.add('${searchIdStudent}');
    }
    if (searchValueScorre != null) {
      conditions.add('${Scorre.fieldValueScorre} like ?');
      Args.add('${searchValueScorre}');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(Scorre.tableName,
        columns: [
          Scorre.fieldId,
          Scorre.fieldIdStudent,
          Scorre.fieldIdClassAcademy,
          Scorre.fieldIdSubject,
          Scorre.fieldIdPhase,
          Scorre.fieldValueScorre
        ],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => Scorre.fromMap(e)).toList();
  }

  Future<Scorre?> getScorre(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(Scorre.tableName,
        columns: [
          Scorre.fieldId,
          Scorre.fieldIdStudent,
          Scorre.fieldIdClassAcademy,
          Scorre.fieldIdSubject,
          Scorre.fieldIdPhase,
          Scorre.fieldValueScorre,
        ],
        where: '${Scorre.fieldId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return Scorre.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM ${Scorre.tableName}')) ??
        0;
  }
}
