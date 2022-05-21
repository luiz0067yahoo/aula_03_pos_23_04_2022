import 'package:aula_03_pos/datasources/local/student_helper.dart';
import 'package:aula_03_pos/models/student.dart';
import 'package:aula_03_pos/ui/components/custom_date_time_field.dart';
import 'package:aula_03_pos/ui/components/custom_radio_option_field.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_student_page.dart';
import 'package:flutter/material.dart';

class CadStudentPage extends StatefulWidget {
  final Student? student;
  final String? modeAction;

  const CadStudentPage({this.modeAction, this.student, Key? key})
      : super(key: key);

  @override
  State<CadStudentPage> createState() => _CadStudentPageState();
}

class _CadStudentPageState extends State<CadStudentPage> {
  final _studentHelper = StudentHelper();
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
    if (widget.student != null) {
      _nameController.text =
          (widget.student!.name == null) ? "" : widget.student!.name!;
      _surNameController.text =
          (widget.student!.name == null) ? "" : widget.student!.surName!;
      _RGController.text =
          (widget.student!.RG == null) ? "" : widget.student!.RG!;
      _CPFController.text =
          (widget.student!.CPF == null) ? "" : widget.student!.CPF!;
      _birthDateController.text = (widget.student!.birthDate == null)
          ? ""
          : widget.student!.birthDate!.toString();
      _sexController.text =
          (widget.student!.sex == null) ? "" : widget.student!.sex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de  Aluno'),
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
                  onPressed: () => _saveStudent(),
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
                    _searchStudent();
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

  void _deleteStudent() {
    CustomMenssage.show(
        context: context,
        title: 'Atenção',
        textDesciption: 'Deseja excluir esse Aluno?',
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
    if (widget.student != null) {
      _studentHelper.Delete(widget.student!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveStudent() {
    if (_nameController.text.isEmpty) {
      CustomMenssage.show(
          context: context,
          title: 'Atenção',
          textDesciption: 'Nome da Aluno é obrigatório!',
          customButtons: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }
    if (widget.student != null) {
      widget.student!.name = _nameController.text;
      widget.student!.surName = _surNameController.text;
      widget.student!.RG = _RGController.text;
      widget.student!.CPF = _CPFController.text;
      widget.student!.birthDate = DateTime.tryParse(_birthDateController.text);
      widget.student!.name = _nameController.text;
      widget.student!.sex = _sexController.text;
      _studentHelper.update(widget.student!);
    } else {
      _studentHelper.insert(Student(
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

  void _searchStudent() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListStudentPage(
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