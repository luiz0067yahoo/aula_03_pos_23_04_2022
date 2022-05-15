import 'package:aula_03_pos/datasources/local/class_academy_subject_professor_helper.dart';
import 'package:aula_03_pos/models/class_academy_subject_professor.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_subject_professor_page.dart';
import 'package:flutter/material.dart';

class CadClassAcademySubjectProfessorPage extends StatefulWidget {
  final ClassAcademySubjectProfessor? classAcademySubjectProfessor;
  final String? modeAction;

  const CadClassAcademySubjectProfessorPage(
      {this.modeAction, this.classAcademySubjectProfessor, Key? key})
      : super(key: key);

  @override
  State<CadClassAcademySubjectProfessorPage> createState() =>
      _CadClassAcademySubjectProfessorPageState();
}

class _CadClassAcademySubjectProfessorPageState
    extends State<CadClassAcademySubjectProfessorPage> {
  final _classAcademySubjectProfessorHelper =
      ClassAcademySubjectProfessorHelper();
  final _idController = TextEditingController();
  final _idSubjectController = TextEditingController();
  final _idProfessorController = TextEditingController();
  final _idClassAcademyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.classAcademySubjectProfessor != null) {
      _idSubjectController.text =
          widget.classAcademySubjectProfessor!.idSubject.toString();
      _idProfessorController.text =
          widget.classAcademySubjectProfessor!.idProfessor.toString();
      _idClassAcademyController.text =
          widget.classAcademySubjectProfessor!.idClassAcademy.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ligar Turma Disciplina Professor'),
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
                  onPressed: () => _saveClassAcademySubjectProfessor(),
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
                    _searchClassAcademySubjectProfessor();
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
              controller: _idProfessorController,
              textDesciption: 'Código Professor'),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  void _deleteClassAcademySubjectProfessor() {
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
    if (widget.classAcademySubjectProfessor != null) {
      _classAcademySubjectProfessorHelper.Delete(
          widget.classAcademySubjectProfessor!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveClassAcademySubjectProfessor() {
    if (widget.classAcademySubjectProfessor != null) {
      widget.classAcademySubjectProfessor!.idClassAcademy =
          int.tryParse(_idClassAcademyController.text);
      widget.classAcademySubjectProfessor!.idSubject =
          int.tryParse(_idSubjectController.text);
      widget.classAcademySubjectProfessor!.idProfessor =
          int.tryParse(_idProfessorController.text);
      _classAcademySubjectProfessorHelper
          .update(widget.classAcademySubjectProfessor!);
    } else {
      _classAcademySubjectProfessorHelper.insert(ClassAcademySubjectProfessor(
        idClassAcademy: int.tryParse(_idClassAcademyController.text),
        idSubject: int.tryParse(_idSubjectController.text),
        idProfessor: int.tryParse(_idProfessorController.text),
      ));
    }
    Navigator.pop(context);
  }

  void _searchClassAcademySubjectProfessor() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListClassAcademySubjectProfessor(
                  searchId: int.tryParse(_idController.text),
                  searchIdClassAcademy: int.tryParse(_idController.text),
                  searchIdSubject: int.tryParse(_idSubjectController.text),
                  searchIdProfessor: int.tryParse(_idProfessorController.text),
                )));
  }
}
