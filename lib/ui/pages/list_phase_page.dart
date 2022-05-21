import 'package:aula_03_pos/datasources/local/phase_helper.dart';
import 'package:aula_03_pos/models/phase.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_phase_page.dart';
import 'package:flutter/material.dart';

class ListPhasePage extends StatefulWidget {
  final int? searchId;
  final String? searchName;
  const ListPhasePage({this.searchId, this.searchName, Key? key})
      : super(key: key);
  @override
  State<ListPhasePage> createState() => _ListPhasePageState();
}

class _ListPhasePageState extends State<ListPhasePage> {
  final _phaseHelper = PhaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fases')),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.blue,
              onPressed: () => _openFormPhase(modeAction: "create"),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 65,
            child: FloatingActionButton(
              heroTag: 'Find',
              backgroundColor: Colors.blue,
              onPressed: () => _openFormPhase(modeAction: "find"),
              child: const Icon(
                Icons.search,
                size: 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _phaseHelper.Find(widget.searchId, widget.searchName),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Phase>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Phase> listaDados) {
    return ListView.builder(
        //padding: const EdgeInsets.all(4),
        itemCount: listaDados.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(listaDados[index], index),
            background: Container(
              alignment: const Alignment(-1, 0),
              color: Colors.blue,
              child: const Text(
                'Editar fase',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir fase',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _openFormPhase(modeAction: "edit", phase: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _phaseHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Atenção',
                    textDesciption: 'Deseja excluir essa phase?',
                    customButtons: [
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      ElevatedButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                    ]);
              }
              return true;
            },
          );
        });
  }

  Widget _criarItemLista(Phase phase, int i) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(0.0),
        color:
            ((i % 2) != 0) ? Color.fromARGB(220, 220, 220, 220) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(
                  width: 30,
                  child: Text(
                    phase.id.toString(),
                    style: const TextStyle(fontSize: 28),
                    textAlign: TextAlign.end,
                  )),
              SizedBox(width: 10),
              SizedBox(
                width: 2,
                height: 30,
                child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black54)),
              ),
              SizedBox(width: 10),
              Text(
                phase.name,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      //onTap: () => _openDetails(phase),
      onLongPress: () => _openFormPhase(modeAction: "edit", phase: phase),
    );
  }

  void _openDetails(Phase phase) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BooksPage(phase)));
  }

  void _openFormPhase({String? modeAction, Phase? phase}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadPhasePage(
                  modeAction: modeAction,
                  phase: phase,
                )));

    setState(() {});
  }
}
