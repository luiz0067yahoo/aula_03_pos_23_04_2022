import 'package:aula_03_pos/datasources/local/class_academy_subject_student_helper.dart';
import 'package:aula_03_pos/models/class_academy_subject_student.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_class_academy_subject_student_page.dart';
import 'package:flutter/material.dart';

class ListClassAcademySubjectStudentPage extends StatefulWidget {
  final int? searchId;
  final int? searchIdClassAcademy;
  final int? searchIdSubject;
  final int? searchIdStudent;
  const ListClassAcademySubjectStudentPage(
      {this.searchId,
      this.searchIdClassAcademy,
      this.searchIdSubject,
      this.searchIdStudent,
      Key? key})
      : super(key: key);
  @override
  State<ListClassAcademySubjectStudentPage> createState() =>
      _ListClassAcademySubjectStudentPageState();
}

class _ListClassAcademySubjectStudentPageState
    extends State<ListClassAcademySubjectStudentPage> {
  final _classAcademySubjectStudentHelper = ClassAcademySubjectStudentHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turma Disiciplina Aluno')),
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
                  _openFormClassAcademySubjectStudent(modeAction: "create"),
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
                  _openFormClassAcademySubjectStudent(modeAction: "find"),
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
        future: _classAcademySubjectStudentHelper.Find(
            widget.searchId,
            widget.searchIdClassAcademy,
            widget.searchIdSubject,
            widget.searchIdStudent),
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
                  snapshot.data as List<ClassAcademySubjectStudent>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<ClassAcademySubjectStudent> listaDados) {
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
                'Editar liga????o',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir liga????o',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _openFormClassAcademySubjectStudent(
                    modeAction: "edit",
                    classAcademySubjectStudent: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _classAcademySubjectStudentHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Aten????o',
                    textDesciption: 'Deseja excluir essa liga????o?',
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

  Widget _criarItemLista(
      ClassAcademySubjectStudent classAcademySubjectStudent, int i) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(0.0),
        color:
            ((i % 2) != 0) ? Color.fromARGB(220, 220, 220, 220) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            SizedBox(
                width: 30,
                child: Text(
                  classAcademySubjectStudent.id.toString(),
                  style: const TextStyle(fontSize: 28),
                  textAlign: TextAlign.end,
                )),
            SizedBox(
              width: 10,
              height: 120,
            ),
            SizedBox(
              width: 2,
              height: 120,
              child: const DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.black54)),
            ),
            SizedBox(
              width: 10,
              height: 120,
            ),
            Column(
              children: [
                SizedBox(width: 10),
                Text(
                  (classAcademySubjectStudent.nameClassAcademy == null)
                      ? ""
                      : classAcademySubjectStudent.nameClassAcademy!,
                  style: const TextStyle(fontSize: 28),
                ),
                Text(
                  (classAcademySubjectStudent.nameSubject == null)
                      ? ""
                      : classAcademySubjectStudent.nameSubject!,
                  style: const TextStyle(fontSize: 28),
                ),
                Text(
                  (classAcademySubjectStudent.nameStudent == null)
                      ? ""
                      : classAcademySubjectStudent.nameStudent!,
                  style: const TextStyle(fontSize: 28),
                ),
              ],
            )
          ]),
        ),
      ),
      //onTap: () => _openDetails(classAcademySubjectStudent),
      onLongPress: () => _openFormClassAcademySubjectStudent(
          modeAction: "edit",
          classAcademySubjectStudent: classAcademySubjectStudent),
    );
  }

  void _openDetails(ClassAcademySubjectStudent classAcademySubjectStudent) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BooksPage(classAcademySubjectStudent)));
  }

  void _openFormClassAcademySubjectStudent(
      {String? modeAction,
      ClassAcademySubjectStudent? classAcademySubjectStudent}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadClassAcademySubjectStudentPage(
                  modeAction: modeAction,
                  classAcademySubjectStudent: classAcademySubjectStudent,
                )));

    setState(() {});
  }
}
