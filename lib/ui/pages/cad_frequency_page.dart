import 'package:aula_03_pos/datasources/local/frequency_helper.dart';
import 'package:aula_03_pos/models/frequency.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_frequency_page.dart';
import 'package:flutter/material.dart';

class CadFrequencyPage extends StatefulWidget {
  final Frequency? frequency;
  final String? modeAction;

  const CadFrequencyPage({this.modeAction, this.frequency, Key? key})
      : super(key: key);

  @override
  State<CadFrequencyPage> createState() => _CadFrequencyPageState();
}

class _CadFrequencyPageState extends State<CadFrequencyPage> {
  final _frequencyHelper = FrequencyHelper();
  final _idController = TextEditingController();
  final _idStudentController = TextEditingController();
  final _idClassAcademyController = TextEditingController();
  final _idSubjectController = TextEditingController();
  final _idPhaseController = TextEditingController();
  final _valueFrequencyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.frequency != null) {
      _idStudentController.text = widget.frequency!.idStudent!.toString();
      _idClassAcademyController.text =
          widget.frequency!.idClassAcademy!.toString();
      _idSubjectController.text = widget.frequency!.idSubject!.toString();
      _idPhaseController.text = widget.frequency!.idPhase!.toString();
      _valueFrequencyController.text =
          widget.frequency!.valueFrequency!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de wuência'),
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
                  onPressed: () => _saveFrequency(),
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
                    _searchFrequency();
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
              controller: _valueFrequencyController,
              textDesciption: 'Valor da Frequência'),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  void _deleteFrequency() {
    CustomMenssage.show(
        context: context,
        title: 'Atenção',
        textDesciption: 'Deseja excluir essa frequência?',
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
    if (widget.frequency != null) {
      _frequencyHelper.Delete(widget.frequency!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _saveFrequency() {
    if (widget.frequency != null) {
      widget.frequency!.idStudent = int.tryParse(_idStudentController.text);
      widget.frequency!.idClassAcademy =
          int.tryParse(_idClassAcademyController.text);
      widget.frequency!.idSubject = int.tryParse(_idSubjectController.text);
      widget.frequency!.idPhase = int.tryParse(_idPhaseController.text);
      widget.frequency!.valueFrequency =
          int.tryParse(_valueFrequencyController.text);
      _frequencyHelper.update(widget.frequency!);
    } else {
      _frequencyHelper.insert(Frequency(
        idStudent: int.tryParse(_idStudentController.text),
        idClassAcademy: int.tryParse(_idClassAcademyController.text),
        idSubject: int.tryParse(_idSubjectController.text),
        idPhase: int.tryParse(_idPhaseController.text),
        valueFrequency: int.tryParse(_valueFrequencyController.text),
      ));
    }
    Navigator.pop(context);
  }

  void _searchFrequency() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListFrequencyPage(
                  searchId: int.tryParse(_idController.text),
                  searchIdClassAcademy:
                      int.tryParse(_idClassAcademyController.text),
                  searchIdSubject: int.tryParse(_idSubjectController.text),
                  searchIdPhase: int.tryParse(_idPhaseController.text),
                  searchValueFrequency:
                      int.tryParse(_valueFrequencyController.text),
                )));
  }
}
