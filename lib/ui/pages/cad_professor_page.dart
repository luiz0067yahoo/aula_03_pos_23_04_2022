import 'package:aula_03_pos/datasources/local/professor_helper.dart';
import 'package:aula_03_pos/models/professor.dart';
import 'package:aula_03_pos/ui/components/custom_date_time_field.dart';
import 'package:aula_03_pos/ui/components/custom_radio_option_field.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_professor_page.dart';
import 'package:flutter/material.dart';

class CadProfessorPage extends StatefulWidget {
  final Professor? professor;
  final String? modeAction;

  const CadProfessorPage({this.modeAction, this.professor, Key? key})
      : super(key: key);

  @override
  State<CadProfessorPage> createState() => _CadProfessorPageState();
}

class _CadProfessorPageState extends State<CadProfessorPage> {
  final _professorHelper = ProfessorHelper();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _surNameController = TextEditingController();
  final _RGController = TextEditingController();
  final _CPFController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _sexController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.professor != null) {
      _nameController.text =
          (widget.professor!.name == null) ? "" : widget.professor!.name!;
      _surNameController.text =
          (widget.professor!.name == null) ? "" : widget.professor!.surName!;
      _RGController.text =
          (widget.professor!.RG == null) ? "" : widget.professor!.RG!;
      _CPFController.text =
          (widget.professor!.CPF == null) ? "" : widget.professor!.CPF!;
      _birthDateController.text = (widget.professor!.birthDate == null)
          ? ""
          : widget.professor!.birthDate!.toString();
      _sexController.text =
          (widget.professor!.sex == null) ? "" : widget.professor!.sex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de  Professor'),
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
                  onPressed: () => _saveProfessor(),
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
                    _searchProfessor();
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
          CustomTextField(
              controller: _surNameController, textDesciption: 'Sobrenome'),
          CustomTextField(controller: _RGController, textDesciption: 'RG'),
          CustomTextField(controller: _CPFController, textDesciption: 'CPF'),
          CustomBasicDateField(
              controller: _birthDateController,
              format: "dd/MM/yyyy",
              textDesciption: "Data Nacimento"),
          CustomRadioOptionField(
              controller: _sexController,
              textDesciption: "sexo",
              groupValue: -1,
              keysValues: {"Masculino": "M", "Feminino": "F"}),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  void _deleteProfessor() {
    CustomMenssage.show(
        context: context,
        title: 'Atenção',
        textDesciption: 'Deseja excluir esse Professor?',
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
    if (widget.professor != null) {
      _professorHelper.Delete(widget.professor!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveProfessor() {
    if (_nameController.text.isEmpty) {
      CustomMenssage.show(
          context: context,
          title: 'Atenção',
          textDesciption: 'Nome da professor é obrigatório!',
          customButtons: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }
    if (widget.professor != null) {
      widget.professor!.name = _nameController.text;
      widget.professor!.surName = _surNameController.text;
      widget.professor!.RG = _RGController.text;
      widget.professor!.CPF = _CPFController.text;
      widget.professor!.birthDate =
          DateTime.tryParse(_birthDateController.text);
      widget.professor!.name = _nameController.text;
      widget.professor!.sex = _sexController.text;
      _professorHelper.update(widget.professor!);
    } else {
      _professorHelper.insert(Professor(
        name: _nameController.text,
        surName: _surNameController.text,
        RG: _RGController.text,
        CPF: _CPFController.text,
        birthDate: DateTime.tryParse(_birthDateController.text),
        sex: _sexController.text,
      ));
    }
    Navigator.pop(context);
  }

  void _searchProfessor() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListProfessorPage(
                  searchId: int.tryParse(_idController.text),
                  searchName: _nameController.text,
                  searchRG: _RGController.text,
                  searchCPF: _CPFController.text,
                  searchBirthDate: DateTime.tryParse(_birthDateController.text),
                  searchSex: _sexController.text,
                )));
  }
}
//aa