import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/frequency.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class FrequencyHelper {
  static const sqlCreateFrequency = '''
    CREATE TABLE IF NOT EXISTS ${Frequency.tableName} (
      ${Frequency.filedId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Frequency.filedIdStudent} INTEGER ,
      ${Frequency.filedIdSubject} INTEGER ,
      ${Frequency.filedIdPhase} INTEGER ,
      ${Frequency.filedValueFrequency} INTEGER 
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
        where: '${Frequency.filedId} = ?', whereArgs: [frequency.id]);
  }

  Future<int> Delete(Frequency frequency) async {
    Database db = await ConectDatabase().db;

    return db.delete(Frequency.tableName,
        where: '${Frequency.filedId} = ?', whereArgs: [frequency.id]);
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
      conditions.add('${Frequency.filedId} like ?');
      Args.add('${searchId}');
    }
    if (searchIdStudent != null) {
      conditions.add('${Frequency.filedIdStudent} like ?');
      Args.add('${searchIdStudent}');
    }
    if (searchIdClassAcademy != null) {
      conditions.add('${Frequency.filedIdClassAcademy} like ?');
      Args.add('${searchIdClassAcademy}');
    }
    if (searchIdSubject != null) {
      conditions.add('${Frequency.filedIdStudent} like ?');
      Args.add('${searchIdStudent}');
    }
    if (searchValueFrequency != null) {
      conditions.add('${Frequency.filedValueFrequency} like ?');
      Args.add('${searchValueFrequency}');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(Frequency.tableName,
        columns: [
          Frequency.filedId,
          Frequency.filedIdStudent,
          Frequency.filedIdClassAcademy,
          Frequency.filedIdSubject,
          Frequency.filedValueFrequency
        ],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => Frequency.fromMap(e)).toList();
  }

  Future<Frequency?> getFrequency(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(Frequency.tableName,
        columns: [
          Frequency.filedId,
          Frequency.filedIdStudent,
          Frequency.filedIdClassAcademy,
          Frequency.filedIdSubject,
          Frequency.filedValueFrequency
        ],
        where: '${Frequency.filedId} = ?',
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
