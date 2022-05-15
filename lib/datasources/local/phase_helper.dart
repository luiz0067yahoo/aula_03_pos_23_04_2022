import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/phase.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class PhaseHelper {
  static const sqlCreatePhase = '''
    CREATE TABLE IF NOT EXISTS ${Phase.tabela} (
      ${Phase.filedId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Phase.filedName} TEXT
    )
  ''';

  Future<Phase> insert(Phase phase) async {
    Database db = await ConectDatabase().db;

    phase.id = await db.insert(Phase.tabela, phase.toMap());
    return phase;
  }

  Future<int> update(Phase phase) async {
    Database db = await ConectDatabase().db;

    return db.update(Phase.tabela, phase.toMap(),
        where: '${Phase.filedId} = ?', whereArgs: [phase.id]);
  }

  Future<int> Delete(Phase phase) async {
    Database db = await ConectDatabase().db;

    return db.delete(Phase.tabela,
        where: '${Phase.filedId} = ?', whereArgs: [phase.id]);
  }

  Future<List<Phase>> All() async {
    Database db = await ConectDatabase().db;
    //List dbData = await db.rawQuery('SELECT * FROM editora');
    List dbData = await db.query(Phase.tabela);
    return dbData.map((e) => Phase.fromMap(e)).toList();
  }

  Future<List<Phase>> Find(int? searchId, String? searchName) async {
    List conditions = [];
    List Args = [];
    if (searchId != null) {
      conditions.add('${Phase.filedId} like ?');
      Args.add('%${searchId}%');
    }
    if (searchName != null) {
      conditions.add('upper(${Phase.filedName}) like ?');
      Args.add('%${searchName.toUpperCase()}%');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(Phase.tabela,
        columns: [Phase.filedId, Phase.filedName],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => Phase.fromMap(e)).toList();
  }

  Future<Phase?> getPhase(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(Phase.tabela,
        columns: [Phase.filedId, Phase.filedName],
        where: '${Phase.filedId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return Phase.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM ${Phase.tabela}')) ??
        0;
  }
}
