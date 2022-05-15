import 'package:aula_03_pos/ui/pages/home_page.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_page.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_subject_professor_page.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_subject_student_page.dart';
import 'package:aula_03_pos/ui/pages/list_frequency_page.dart';
import 'package:aula_03_pos/ui/pages/list_phase_page.dart';
import 'package:aula_03_pos/ui/pages/list_professor_page.dart';
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
        '/student': (context) => ListStudent(),
        '/professor': (context) => ListProfessor(),
        '/scorre': (context) => ListScorre(),
        '/frequency': (context) => ListFrequency(),
        '/phase': (context) => ListPhase(),
        '/subject': (context) => ListSubject(),
        '/class_academy': (context) => ListClassAcademy(),
        '/class_academy_suject_professor': (context) =>
            ListClassAcademySubjectProfessor(),
        '/class_academy_suject_student': (context) =>
            ListClassAcademySubjectStudent(),
      },
    );
  }
}
