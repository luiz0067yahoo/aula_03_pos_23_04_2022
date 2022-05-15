import 'package:aula_03_pos/datasources/local/class_academy_subject_student_helper.dart';
import 'package:aula_03_pos/models/class_academy_subject_student.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_subject_student_page.dart';
import 'package:flutter/material.dart';

class CadClassAcademySubjectStudentPage extends StatefulWidget {
  final ClassAcademySubjectStudent? classAcademySubjectStudent;
  final String? modeAction;

  const CadClassAcademySubjectStudentPage(
      {this.modeAction, this.classAcademySubjectStudent, Key? key})
      : super(key: key);

  @override
  State<CadClassAcademySubjectStudentPage> createState() =>
      _CadClassAcademySubjectStudentPageState();
}

class _CadClassAcademySubjectStudentPageState
    extends State<CadClassAcademySubjectStudentPage> {
  final _classAcademySubjectStudentHelper = ClassAcademySubjectStudentHelper();
  final _idController = TextEditingController();
  final _idSubjectController = TextEditingController();
  final _idStudentController = TextEditingController();
  final _idClassAcademyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.classAcademySubjectStudent != null) {
      _idSubjectController.text =
          widget.classAcademySubjectStudent!.idSubject.toString();
      _idStudentController.text =
          widget.classAcademySubjectStudent!.idStudent.toString();
      _idClassAcademyController.text =
          widget.classAcademySubjectStudent!.idClassAcademy.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ligar Turma Disciplina Student'),
      ),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Visibility(
              visible: (widget.modeAction == "edit" ||
                  widget.modeAction == "create"),
              child: Positioned(
                bottom: 5,
                right: 5,
                child: FloatingActionButton(
                  heroTag: 'Save',
                  backgroundColor: Colors.black,
                  onPressed: () => _saveClassAcademySubjectStudent(),
                  child: const Icon(
                    Icons.save,
                    size: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),
          Visibility(
              visible: widget.modeAction == "edit",
              child: Positioned(
                bottom: 5,
                right: 65,
                child: FloatingActionButton(
                  heroTag: 'Delete',
                  backgroundColor: Colors.red,
                  onPressed: () {
                    _deleteConfirm();
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),
          Visibility(
              visible: widget.modeAction == "find",
              child: Positioned(
                bottom: 5,
                right: 5,
                child: FloatingActionButton(
                  heroTag: 'search',
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    _searchClassAcademySubjectStudent();
                  },
                  child: const Icon(
                    Icons.search,
                    size: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),
        ],
      ),
      body: ListView(
        children: [
          Visibility(
              visible: (widget.modeAction == "find"),
              child: CustomTextField(
                  controller: _idController, textDesciption: 'Código')),
          CustomTextField(
              controller: _idClassAcademyController,
              textDesciption: 'Código Turma'),
          CustomTextField(
              controller: _idSubjectController,
              textDesciption: 'Código Disciplina'),
          CustomTextField(
              controller: _idStudentController,
              textDesciption: 'Código Student'),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  void _deleteClassAcademySubjectStudent() {
    CustomMenssage.show(
        context: context,
        title: 'Atenção',
        textDesciption: 'Deseja excluir essa Ligação?',
        customButtons: [
          TextButton(child: const Text('Sim'), onPressed: _deleteConfirm),
          ElevatedButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ]);
  }

  void _deleteConfirm() {
    if (widget.classAcademySubjectStudent != null) {
      _classAcademySubjectStudentHelper.Delete(
          widget.classAcademySubjectStudent!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveClassAcademySubjectStudent() {
    if (widget.classAcademySubjectStudent != null) {
      widget.classAcademySubjectStudent!.idClassAcademy =
          int.tryParse(_idClassAcademyController.text);
      widget.classAcademySubjectStudent!.idSubject =
          int.tryParse(_idSubjectController.text);
      widget.classAcademySubjectStudent!.idStudent =
          int.tryParse(_idStudentController.text);
      _classAcademySubjectStudentHelper
          .update(widget.classAcademySubjectStudent!);
    } else {
      _classAcademySubjectStudentHelper.insert(ClassAcademySubjectStudent(
        idClassAcademy: int.tryParse(_idClassAcademyController.text),
        idSubject: int.tryParse(_idSubjectController.text),
        idStudent: int.tryParse(_idStudentController.text),
      ));
    }
    Navigator.pop(context);
  }

  void _searchClassAcademySubjectStudent() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListClassAcademySubjectStudent(
                  searchId: int.tryParse(_idController.text),
                  searchIdClassAcademy: int.tryParse(_idController.text),
                  searchIdSubject: int.tryParse(_idSubjectController.text),
                  searchIdStudent: int.tryParse(_idStudentController.text),
                )));
  }
}
