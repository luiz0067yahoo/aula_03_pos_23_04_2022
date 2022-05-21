import 'package:aula_03_pos/datasources/local/conect_database.dart';
import 'package:aula_03_pos/models/class_academy.dart';
import 'package:aula_03_pos/models/class_academy_subject_student.dart';
import 'package:aula_03_pos/models/frequency.dart';
import 'package:aula_03_pos/models/phase.dart';
import 'package:aula_03_pos/models/report_card.dart';
import 'package:aula_03_pos/models/scorre.dart';
import 'package:aula_03_pos/models/student.dart';
import 'package:aula_03_pos/models/subject.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class ReportCardHelper {
  Future<List<ReportCard>> Find(
    int? searchIdStudent,
  ) async {
    Database db = await ConectDatabase().db;
    List conditions = [];
    List Args = [];

    if (searchIdStudent != null) {
      conditions.add('${ReportCard.fieldIdStudent} like ?');
      Args.add('${searchIdStudent}');
    }

    List dbData = await db.rawQuery('''
      SELECT  
              C.${ClassAcademy.fieldId}  as ${ReportCard.fieldIdClassAcademy},
              STD.${Student.fieldId}  as ${ReportCard.fieldIdStudent},
              SCR.${Scorre.fieldId}  as ${ReportCard.fieldIdScorre},
              F.${Frequency.fieldId}  as ${ReportCard.fieldIdFrequency},
              S.${Subject.fieldId}  as ${ReportCard.fieldIdSubject},
              P.${Phase.fieldId}  as ${ReportCard.fieldIdPhase},
              C.${ClassAcademy.fieldName}  as ${ReportCard.fieldNameClassAcademy},
              P.${Subject.fieldName}  as ${ReportCard.fieldNameSubject},
              STD.${Student.fieldName}  as ${ReportCard.fieldNameStudent},
              SCR.${Scorre.fieldValueScorre}  as ${ReportCard.fieldValueScorre},
              F.${Frequency.fieldValueFrequency}  as ${ReportCard.fieldValueFrequency},
              S.${Subject.fieldName}  as ${ReportCard.fieldNameSubject},
              P.${Phase.fieldName}  as ${ReportCard.fieldNamePhase}
      FROM ${ClassAcademySubjectStudent.tableName}  CASS
      LEFT JOIN ${ClassAcademy.tableName} C ON (CASS.${ClassAcademySubjectStudent.fieldIdClassAcademy}=C.${Student.fieldId})
      LEFT JOIN ${Student.tableName} STD ON (CASS.${ClassAcademySubjectStudent.fieldIdStudent}=STD.${Student.fieldId})
      LEFT JOIN ${Scorre.tableName} SCR ON (SCR.${Scorre.fieldIdStudent}=STD.${Student.fieldId})
      LEFT JOIN ${Frequency.tableName} F ON ((F.${Frequency.fieldIdStudent}=STD.${Student.fieldId}) AND (F.${Frequency.fieldIdPhase}=SCR.${Scorre.fieldIdPhase}))
      LEFT JOIN ${Subject.tableName} S ON ((F.${Frequency.fieldIdSubject}=S.${Subject.fieldId}) AND (P.${Phase.fieldId}=S.${Subject.fieldId}))  
      LEFT JOIN ${Phase.tableName} P ON ((P.${Phase.fieldId}=F.${Frequency.fieldIdPhase}) AND (P.${Phase.fieldId}=SCR.${Scorre.fieldIdPhase}))
      
       ${(conditions.length > 0) ? " WHERE  " + conditions.join(" and ") : ""}
     
      
      ORDER BY
      STD.${Student.fieldName} ASC,
      S.${Subject.fieldName} ASC,
      P.${Phase.fieldId} ASC
    ''', Args);

    return dbData.map((e) => ReportCard.fromMap(e)).toList();
  }
}
