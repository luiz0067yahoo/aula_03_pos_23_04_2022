import 'package:aula_03_pos/datasources/local/scorre_helper.dart';
import 'package:aula_03_pos/models/scorre.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_scorre_page.dart';
import 'package:flutter/material.dart';

class CadScorrePage extends StatefulWidget {
  final Scorre? scorre;
  final String? modeAction;

  const CadScorrePage({this.modeAction, this.scorre, Key? key})
      : super(key: key);

  @override
  State<CadScorrePage> createState() => _CadScorrePageState();
}

class _CadScorrePageState extends State<CadScorrePage> {
  final _scorreHelper = ScorreHelper();
  final _idController = TextEditingController();
  final _idStudentController = TextEditingController();
  final _idClassAcademyController = TextEditingController();
  final _idSubjectController = TextEditingController();
  final _idPhaseController = TextEditingController();
  final _valueScorreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.scorre != null) {
      _idStudentController.text = widget.scorre!.idStudent!.toString();
      _idClassAcademyController.text = (widget.scorre!.idClassAcademy == null)
          ? ""
          : widget.scorre!.idClassAcademy!.toString();
      _idSubjectController.text = (widget.scorre!.idSubject == null)
          ? ""
          : widget.scorre!.idSubject!.toString();
      _idPhaseController.text = (widget.scorre!.idPhase == null)
          ? ""
          : widget.scorre!.idPhase!.toString();
      _valueScorreController.text = (widget.scorre!.valueScorre == null)
          ? ""
          : widget.scorre!.valueScorre!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Nota'),
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
                  onPressed: () => _saveScorre(),
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
                    _searchScorre();
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
              controller: _idStudentController, textDesciption: 'Código Aluno'),
          CustomTextField(
              controller: _idClassAcademyController,
              textDesciption: 'Código Truma'),
          CustomTextField(
              controller: _idSubjectController,
              textDesciption: 'Código Diciplina'),
          CustomTextField(
              controller: _idPhaseController, textDesciption: 'Código Fase'),
          CustomTextField(
              controller: _valueScorreController,
              textDesciption: 'Valor da Nota'),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  void _deleteScorre() {
    CustomMenssage.show(
        context: context,
        title: 'Atenção',
        textDesciption: 'Deseja excluir essa nota?',
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
    if (widget.scorre != null) {
      _scorreHelper.Delete(widget.scorre!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveScorre() {
    if (widget.scorre != null) {
      widget.scorre!.idStudent = int.tryParse(_idStudentController.text);
      widget.scorre!.idClassAcademy =
          int.tryParse(_idClassAcademyController.text);
      widget.scorre!.idSubject = int.tryParse(_idSubjectController.text);
      widget.scorre!.idPhase = int.tryParse(_idPhaseController.text);
      widget.scorre!.valueScorre = int.tryParse(_valueScorreController.text);
      _scorreHelper.update(widget.scorre!);
    } else {
      _scorreHelper.insert(Scorre(
        idStudent: int.tryParse(_idStudentController.text),
        idClassAcademy: int.tryParse(_idClassAcademyController.text),
        idSubject: int.tryParse(_idSubjectController.text),
        idPhase: int.tryParse(_idPhaseController.text),
        valueScorre: int.tryParse(_valueScorreController.text),
      ));
    }
    Navigator.pop(context);
  }

  void _searchScorre() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListScorrePage(
                  searchId: int.tryParse(_idController.text),
                  searchIdClassAcademy:
                      int.tryParse(_idClassAcademyController.text),
                  searchIdSubject: int.tryParse(_idSubjectController.text),
                  searchIdPhase: int.tryParse(_idPhaseController.text),
                  searchValueScorre: int.tryParse(_valueScorreController.text),
                )));
  }
}
