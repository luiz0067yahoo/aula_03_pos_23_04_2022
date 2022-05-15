import 'package:aula_03_pos/datasources/local/class_academy_subject_professor_helper.dart';
import 'package:aula_03_pos/models/class_academy_subject_professor.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_class_academy_subject_professor_page.dart';
import 'package:flutter/material.dart';

class ListClassAcademySubjectProfessor extends StatefulWidget {
  final int? searchId;
  final int? searchIdClassAcademy;
  final int? searchIdSubject;
  final int? searchIdProfessor;
  const ListClassAcademySubjectProfessor(
      {this.searchId,
      this.searchIdClassAcademy,
      this.searchIdSubject,
      this.searchIdProfessor,
      Key? key})
      : super(key: key);
  @override
  State<ListClassAcademySubjectProfessor> createState() =>
      _ListClassAcademySubjectProfessorState();
}

class _ListClassAcademySubjectProfessorState
    extends State<ListClassAcademySubjectProfessor> {
  final _classAcademySubjectProfessorHelper =
      ClassAcademySubjectProfessorHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turma Disiciplina Professor')),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.blue,
              onPressed: () =>
                  _openFormClassAcademySubjectProfessor(modeAction: "create"),
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
              onPressed: () =>
                  _openFormClassAcademySubjectProfessor(modeAction: "find"),
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
        future: _classAcademySubjectProfessorHelper.Find(
            widget.searchId,
            widget.searchIdClassAcademy,
            widget.searchIdSubject,
            widget.searchIdProfessor),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(
                  snapshot.data as List<ClassAcademySubjectProfessor>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<ClassAcademySubjectProfessor> listaDados) {
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
                'Editar ligação',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir ligação',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _openFormClassAcademySubjectProfessor(
                    modeAction: "edit",
                    classAcademySubjectProfessor: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _classAcademySubjectProfessorHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Atenção',
                    textDesciption: 'Deseja excluir essa ligação?',
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

  Widget _criarItemLista(
      ClassAcademySubjectProfessor classAcademySubjectProfessor, int i) {
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
                    classAcademySubjectProfessor.id.toString(),
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
                classAcademySubjectProfessor.idClassAcademy.toString(),
                style: const TextStyle(fontSize: 28),
              ),
              SizedBox(
                width: 2,
                height: 30,
                child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black54)),
              ),
              SizedBox(width: 10),
              Text(
                classAcademySubjectProfessor.idSubject.toString(),
                style: const TextStyle(fontSize: 28),
              ),
              SizedBox(
                width: 2,
                height: 30,
                child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black54)),
              ),
              SizedBox(width: 10),
              Text(
                classAcademySubjectProfessor.idProfessor.toString(),
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      //onTap: () => _openDetails(classAcademySubjectProfessor),
      onLongPress: () => _openFormClassAcademySubjectProfessor(
          modeAction: "edit",
          classAcademySubjectProfessor: classAcademySubjectProfessor),
    );
  }

  void _openDetails(ClassAcademySubjectProfessor classAcademySubjectProfessor) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BooksPage(classAcademySubjectProfessor)));
  }

  void _openFormClassAcademySubjectProfessor(
      {String? modeAction,
      ClassAcademySubjectProfessor? classAcademySubjectProfessor}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadClassAcademySubjectProfessorPage(
                  modeAction: modeAction,
                  classAcademySubjectProfessor: classAcademySubjectProfessor,
                )));

    setState(() {});
  }
}
