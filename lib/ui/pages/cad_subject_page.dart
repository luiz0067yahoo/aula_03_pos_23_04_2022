import 'package:aula_03_pos/datasources/local/subject_helper.dart';
import 'package:aula_03_pos/models/subject.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_subject_page.dart';
import 'package:flutter/material.dart';

class CadSubjectPage extends StatefulWidget {
  final Subject? subject;
  final String? modeAction;

  const CadSubjectPage({this.modeAction, this.subject, Key? key})
      : super(key: key);

  @override
  State<CadSubjectPage> createState() => _CadSubjectPageState();
}

class _CadSubjectPageState extends State<CadSubjectPage> {
  final _subjectHelper = SubjectHelper();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.subject != null) {
      _nameController.text = widget.subject!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Turma'),
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
                  onPressed: () => _saveSubject(),
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
                    _searchSubject();
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
          CustomTextField(controller: _nameController, textDesciption: 'Nome'),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  void _deleteSubject() {
    CustomMenssage.show(
        context: context,
        title: 'Atenção',
        textDesciption: 'Deseja excluir essa Turma?',
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
    if (widget.subject != null) {
      _subjectHelper.Delete(widget.subject!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveSubject() {
    if (_nameController.text.isEmpty) {
      CustomMenssage.show(
          context: context,
          title: 'Atenção',
          textDesciption: 'Nome da subject é obrigatório!',
          customButtons: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }
    if (widget.subject != null) {
      widget.subject!.name = _nameController.text;
      _subjectHelper.update(widget.subject!);
    } else {
      _subjectHelper.insert(Subject(name: _nameController.text));
    }
    Navigator.pop(context);
  }

  void _searchSubject() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListSubject(
                  searchId: int.tryParse(_idController.text),
                  searchName: _nameController.text,
                )));
  }
}
