import 'package:aula_03_pos/datasources/local/class_academy_helper.dart';
import 'package:aula_03_pos/models/class_academy.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_class_academy_page.dart';
import 'package:flutter/material.dart';

class CadClassAcademyPage extends StatefulWidget {
  final ClassAcademy? classAcademy;
  final String? modeAction;

  const CadClassAcademyPage({this.modeAction, this.classAcademy, Key? key})
      : super(key: key);

  @override
  State<CadClassAcademyPage> createState() => _CadClassAcademyPageState();
}

class _CadClassAcademyPageState extends State<CadClassAcademyPage> {
  final _classAcademyHelper = ClassAcademyHelper();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.classAcademy != null) {
      _nameController.text = widget.classAcademy!.name;
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
                  onPressed: () => _saveClassAcademy(),
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
                    _searchClassAcademy();
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

  void _deleteClassAcademy() {
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
    if (widget.classAcademy != null) {
      _classAcademyHelper.Delete(widget.classAcademy!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveClassAcademy() {
    if (_nameController.text.isEmpty) {
      CustomMenssage.show(
          context: context,
          title: 'Atenção',
          textDesciption: 'Nome da Turma é obrigatório!',
          customButtons: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }
    if (widget.classAcademy != null) {
      widget.classAcademy!.name = _nameController.text;
      _classAcademyHelper.update(widget.classAcademy!);
    } else {
      _classAcademyHelper.insert(ClassAcademy(name: _nameController.text));
    }
    Navigator.pop(context);
  }

  void _searchClassAcademy() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListClassAcademyPage(
                  searchId: int.tryParse(_idController.text),
                  searchName: _nameController.text,
                )));
  }
}
