import 'package:aula_03_pos/datasources/local/phase_helper.dart';
import 'package:aula_03_pos/models/phase.dart';
import 'package:aula_03_pos/ui/components/custom_text_field.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/list_phase_page.dart';
import 'package:flutter/material.dart';

class CadPhasePage extends StatefulWidget {
  final Phase? phase;
  final String? modeAction;

  const CadPhasePage({this.modeAction, this.phase, Key? key}) : super(key: key);

  @override
  State<CadPhasePage> createState() => _CadPhasePageState();
}

class _CadPhasePageState extends State<CadPhasePage> {
  final _phaseHelper = PhaseHelper();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.phase != null) {
      _nameController.text = widget.phase!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Fase'),
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
                  onPressed: () => _savePhase(),
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
                    _searchPhase();
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

  void _deletePhase() {
    CustomMenssage.show(
        context: context,
        title: 'Atenção',
        textDesciption: 'Deseja excluir essa fase?',
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
    if (widget.phase != null) {
      _phaseHelper.Delete(widget.phase!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _savePhase() {
    if (_nameController.text.isEmpty) {
      CustomMenssage.show(
          context: context,
          title: 'Atenção',
          textDesciption: 'Nome da phase é obrigatório!',
          customButtons: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }
    if (widget.phase != null) {
      widget.phase!.name = _nameController.text;
      _phaseHelper.update(widget.phase!);
    } else {
      _phaseHelper.insert(Phase(name: _nameController.text));
    }
    Navigator.pop(context);
  }

  void _searchPhase() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListPhase(
                  searchId: int.tryParse(_idController.text),
                  searchName: _nameController.text,
                )));
  }
}
