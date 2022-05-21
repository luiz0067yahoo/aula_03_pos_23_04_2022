import 'package:aula_03_pos/ui/pages/home_page.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_page.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_subject_professor_page.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_subject_student_page.dart';
import 'package:aula_03_pos/ui/pages/list_frequency_page.dart';
import 'package:aula_03_pos/ui/pages/list_phase_page.dart';
import 'package:aula_03_pos/ui/pages/list_professor_page.dart';
import 'package:aula_03_pos/ui/pages/list_report_card_page.dart';
import 'package:aula_03_pos/ui/pages/list_scorre_page.dart';
import 'package:aula_03_pos/ui/pages/list_student_page.dart';
import 'package:aula_03_pos/ui/pages/list_subject_page.dart';
import 'package:flutter/material.dart';

class mainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escola',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/home': (context) => HomePage(),
        '/student': (context) => ListStudentPage(),
        '/professor': (context) => ListProfessorPage(),
        '/scorre': (context) => ListScorrePage(),
        '/frequency': (context) => ListFrequencyPage(),
        '/phase': (context) => ListPhasePage(),
        '/subject': (context) => ListSubjectPage(),
        '/class_academy': (context) => ListClassAcademyPage(),
        '/class_academy_suject_professor': (context) =>
            ListClassAcademySubjectProfessorPage(),
        '/class_academy_suject_student': (context) =>
            ListClassAcademySubjectStudentPage(),
        '/report_card': (context) => ListReportCardPage(),
      },
    );
  }
}
