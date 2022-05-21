import 'package:aula_03_pos/datasources/local/class_academy_helper.dart';
import 'package:aula_03_pos/datasources/local/class_academy_subject_professor_helper.dart';
import 'package:aula_03_pos/datasources/local/class_academy_subject_student_helper.dart';
import 'package:aula_03_pos/datasources/local/frequency_helper.dart';
import 'package:aula_03_pos/datasources/local/phase_helper.dart';
import 'package:aula_03_pos/datasources/local/professor_helper.dart';
import 'package:aula_03_pos/datasources/local/scorre_helper.dart';
import 'package:aula_03_pos/datasources/local/student_helper.dart';
import 'package:aula_03_pos/datasources/local/subject_helper.dart';
import 'package:aula_03_pos/models/class_academy.dart';
import 'package:aula_03_pos/models/class_academy_subject_student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConectDatabase {
  static const String _nomeBanco = 'academy.db';

  static final ConectDatabase _instance = ConectDatabase.internal();
  factory ConectDatabase() => _instance;
  ConectDatabase.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    await _db!.execute(PhaseHelper.sqlCreatePhase);
    await _db!.execute(ClassAcademyHelper.sqlCreateClassAcademy);
    await _db!.execute(SubjectHelper.sqlCreateSubject);
    await _db!.execute(StudentHelper.sqlCreateStudent);
    await _db!.execute(ProfessorHelper.sqlCreateProfessor);
    await _db!.execute(FrequencyHelper.sqlCreateFrequency);
    await _db!.execute(ScorreHelper.sqlCreateScorre);
    await _db!.execute(ClassAcademySubjectProfessorHelper
        .sqlCreateClassAcademySubjectProfessor);

    await _db!.execute(
        ClassAcademySubjectStudentHelper.sqlCreateClassAcademySubjectStudent);
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final pathDb = join(path, _nomeBanco);

    return await openDatabase(pathDb,
        version: 1, onCreate: (Database db, int version) async {});
  }

  void close() async {
    Database OutherDb = await db;
    OutherDb.close();
  }
}
