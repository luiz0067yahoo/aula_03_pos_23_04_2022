import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/professor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ProfessorHelper {
  static const sqlCreateProfessor = '''
    CREATE TABLE IF NOT EXISTS ${Professor.tableName} (
      ${Professor.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Professor.fieldName} TEXT,
      ${Professor.fieldSurName} TEXT,
      ${Professor.fieldRG} TEXT,
      ${Professor.fieldCPF} TEXT,
      ${Professor.fieldBirthDate} DATETIME,
      ${Professor.fieldSex} TEXT
    )
  ''';

  Future<Professor> insert(Professor professor) async {
    Database db = await ConectDatabase().db;

    professor.id = await db.insert(Professor.tableName, professor.toMap());
    return professor;
  }

  Future<int> update(Professor professor) async {
    Database db = await ConectDatabase().db;

    return db.update(Professor.tableName, professor.toMap(),
        where: '${Professor.fieldId} = ?', whereArgs: [professor.id]);
  }

  Future<int> Delete(Professor professor) async {
    Database db = await ConectDatabase().db;

    return db.delete(Professor.tableName,
        where: '${Professor.fieldId} = ?', whereArgs: [professor.id]);
  }

  Future<List<Professor>> All() async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(
      Professor.tableName,
      columns: [
        Professor.fieldId,
        Professor.fieldName,
        Professor.fieldSurName,
        Professor.fieldRG,
        Professor.fieldCPF,
        Professor.fieldBirthDate,
        Professor.fieldSex
      ],
    );
    return dbData.map((e) => Professor.fromMap(e)).toList();
  }

  Future<List<Professor>> Find(
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
      conditions.add('${Professor.fieldId} like ?');
      Args.add('%${searchId}%');
    }
    if ((searchName != null) && (searchName.length > 0)) {
      conditions.add('upper(${Professor.fieldName}) like ?');
      Args.add('%${searchName.toUpperCase()}%');
    }
    if ((searchSureName != null) && (searchSureName.length > 0)) {
      conditions.add('upper(${Professor.fieldSurName}) like ?');
      Args.add('%${searchSureName.toUpperCase()}%');
    }
    if ((searchRG != null) && (searchRG.length > 0)) {
      conditions.add('upper(${Professor.fieldRG}) like ?');
      Args.add('%${searchRG.toUpperCase()}%');
    }
    if ((searchCPF != null) && (searchCPF.length > 0)) {
      conditions.add('upper(${Professor.fieldCPF}) like ?');
      Args.add('%${searchCPF.toUpperCase()}%');
    }
    if ((searchBirthDate != null)) {
      conditions.add('upper(${Professor.fieldBirthDate}) like ?');
      Args.add('%${searchBirthDate}%');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(Professor.tableName,
        columns: [
          Professor.fieldId,
          Professor.fieldName,
          Professor.fieldSurName,
          Professor.fieldRG,
          Professor.fieldCPF,
          Professor.fieldBirthDate,
          Professor.fieldSex
        ],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => Professor.fromMap(e)).toList();
  }

  Future<Professor?> getProfessor(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(Professor.tableName,
        columns: [Professor.fieldId, Professor.fieldName],
        where: '${Professor.fieldId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return Professor.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM ${Professor.tableName}')) ??
        0;
  }
}
