import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/frequency.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class FrequencyHelper {
  static const sqlDropFrequency = '''

    DROP TABLE IF  EXISTS ${Frequency.tableName} ;s
  ''';
  static const sqlCreateFrequency = '''
    CREATE TABLE IF NOT EXISTS ${Frequency.tableName} (
      ${Frequency.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Frequency.fieldIdStudent} INTEGER ,
      ${Frequency.fieldIdSubject} INTEGER ,
      ${Frequency.fieldIdClassAcademy} INTEGER ,
      ${Frequency.fieldIdPhase} INTEGER ,
      ${Frequency.fieldValueFrequency} INTEGER 
    )
  ''';

  Future<Frequency> insert(Frequency frequency) async {
    Database db = await ConectDatabase().db;

    frequency.id = await db.insert(Frequency.tableName, frequency.toMap());
    return frequency;
  }

  Future<int> update(Frequency frequency) async {
    Database db = await ConectDatabase().db;

    return db.update(Frequency.tableName, frequency.toMap(),
        where: '${Frequency.fieldId} = ?', whereArgs: [frequency.id]);
  }

  Future<int> Delete(Frequency frequency) async {
    Database db = await ConectDatabase().db;

    return db.delete(Frequency.tableName,
        where: '${Frequency.fieldId} = ?', whereArgs: [frequency.id]);
  }

  Future<List<Frequency>> All() async {
    Database db = await ConectDatabase().db;
    //List dbData = await db.rawQuery('SELECT * FROM editora');
    List dbData = await db.query(Frequency.tableName);
    return dbData.map((e) => Frequency.fromMap(e)).toList();
  }

  Future<List<Frequency>> Find(
      int? searchId,
      int? searchIdStudent,
      int? searchIdClassAcademy,
      int? searchIdSubject,
      int? searchIdPhase,
      int? searchValueFrequency) async {
    List conditions = [];
    List Args = [];
    if (searchId != null) {
      conditions.add('${Frequency.fieldId} like ?');
      Args.add('${searchId}');
    }
    if (searchIdStudent != null) {
      conditions.add('${Frequency.fieldIdStudent} like ?');
      Args.add('${searchIdStudent}');
    }
    if (searchIdClassAcademy != null) {
      conditions.add('${Frequency.fieldIdClassAcademy} like ?');
      Args.add('${searchIdClassAcademy}');
    }
    if (searchIdSubject != null) {
      conditions.add('${Frequency.fieldIdStudent} like ?');
      Args.add('${searchIdStudent}');
    }
    if (searchValueFrequency != null) {
      conditions.add('${Frequency.fieldValueFrequency} like ?');
      Args.add('${searchValueFrequency}');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(Frequency.tableName,
        columns: [
          Frequency.fieldId,
          Frequency.fieldIdStudent,
          Frequency.fieldIdClassAcademy,
          Frequency.fieldIdSubject,
          Frequency.fieldIdPhase,
          Frequency.fieldValueFrequency
        ],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => Frequency.fromMap(e)).toList();
  }

  Future<Frequency?> getFrequency(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(Frequency.tableName,
        columns: [
          Frequency.fieldId,
          Frequency.fieldIdStudent,
          Frequency.fieldIdClassAcademy,
          Frequency.fieldIdSubject,
          Frequency.fieldIdPhase,
          Frequency.fieldValueFrequency,
        ],
        where: '${Frequency.fieldId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return Frequency.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM ${Frequency.tableName}')) ??
        0;
  }
}
