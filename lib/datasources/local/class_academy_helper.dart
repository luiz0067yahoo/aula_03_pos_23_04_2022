import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/class_academy.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ClassAcademyHelper {
  static const sqlCreateClassAcademy = '''
    CREATE TABLE IF NOT EXISTS ${ClassAcademy.tableName} (
      ${ClassAcademy.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ClassAcademy.fieldName} TEXT
    )
  ''';

  Future<ClassAcademy> insert(ClassAcademy classAcademy) async {
    Database db = await ConectDatabase().db;

    classAcademy.id =
        await db.insert(ClassAcademy.tableName, classAcademy.toMap());
    return classAcademy;
  }

  Future<int> update(ClassAcademy classAcademy) async {
    Database db = await ConectDatabase().db;

    return db.update(ClassAcademy.tableName, classAcademy.toMap(),
        where: '${ClassAcademy.fieldId} = ?', whereArgs: [classAcademy.id]);
  }

  Future<int> Delete(ClassAcademy classAcademy) async {
    Database db = await ConectDatabase().db;

    return db.delete(ClassAcademy.tableName,
        where: '${ClassAcademy.fieldId} = ?', whereArgs: [classAcademy.id]);
  }

  Future<List<ClassAcademy>> All() async {
    Database db = await ConectDatabase().db;
    //List dbData = await db.rawQuery('SELECT * FROM editora');
    List dbData = await db.query(ClassAcademy.tableName);
    return dbData.map((e) => ClassAcademy.fromMap(e)).toList();
  }

  Future<List<ClassAcademy>> Find(int? searchId, String? searchName) async {
    List conditions = [];
    List Args = [];
    if (searchId != null) {
      conditions.add('${ClassAcademy.fieldId} like ?');
      Args.add('%${searchId}%');
    }
    if (searchName != null) {
      conditions.add('upper(${ClassAcademy.fieldName}) like ?');
      Args.add('%${searchName.toUpperCase()}%');
    }

    Database db = await ConectDatabase().db;
    List dbData = await db.query(ClassAcademy.tableName,
        columns: [ClassAcademy.fieldId, ClassAcademy.fieldName],
        where: (conditions.length > 0) ? conditions.join(" and ") : null,
        whereArgs: (conditions.length > 0) ? Args : null);
    return dbData.map((e) => ClassAcademy.fromMap(e)).toList();
  }

  Future<ClassAcademy?> getClassAcademy(int id) async {
    Database db = await ConectDatabase().db;
    List dbData = await db.query(ClassAcademy.tableName,
        columns: [ClassAcademy.fieldId, ClassAcademy.fieldName],
        where: '${ClassAcademy.fieldId} = ?',
        whereArgs: [id]);

    if (dbData.isNotEmpty) {
      return ClassAcademy.fromMap(dbData.first);
    }
    return null;
  }

  Future<int> getCount() async {
    Database db = await ConectDatabase().db;

    return firstIntValue(await db
            .rawQuery('SELECT COUNT(*) FROM ${ClassAcademy.tableName}')) ??
        0;
  }
}
