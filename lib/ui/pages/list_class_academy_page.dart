import 'package:aula_03_pos/datasources/local/class_academy_helper.dart';
import 'package:aula_03_pos/models/class_academy.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_class_academy_page.dart';
import 'package:flutter/material.dart';

class ListClassAcademyPage extends StatefulWidget {
  final int? searchId;
  final String? searchName;
  const ListClassAcademyPage({this.searchId, this.searchName, Key? key})
      : super(key: key);
  @override
  State<ListClassAcademyPage> createState() => _ListClassAcademyPageState();
}

class _ListClassAcademyPageState extends State<ListClassAcademyPage> {
  final _classAcademyHelper = ClassAcademyHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turmas')),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.blue,
              onPressed: () => _openFormClassAcademy(modeAction: "create"),
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
              onPressed: () => _openFormClassAcademy(modeAction: "find"),
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
        future: _classAcademyHelper.Find(widget.searchId, widget.searchName),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<ClassAcademy>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<ClassAcademy> listaDados) {
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
                'Editar Turma',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir Turma',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _openFormClassAcademy(
                    modeAction: "edit", classAcademy: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _classAcademyHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Aten????o',
                    textDesciption: 'Deseja excluir essa Turma?',
                    customButtons: [
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      ElevatedButton(
                          child: const Text('N??o'),
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

  Widget _criarItemLista(ClassAcademy classAcademy, int i) {
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
                    classAcademy.id.toString(),
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
                classAcademy.name,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      //onTap: () => _abrirListaLivros(classAcademy),
      onLongPress: () =>
          _openFormClassAcademy(modeAction: "edit", classAcademy: classAcademy),
    );
  }

  void _openFormClassAcademy(
      {String? modeAction, ClassAcademy? classAcademy}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadClassAcademyPage(
                  modeAction: modeAction,
                  classAcademy: classAcademy,
                )));

    setState(() {});
  }
}
