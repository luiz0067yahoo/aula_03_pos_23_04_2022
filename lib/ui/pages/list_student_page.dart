import 'package:aula_03_pos/datasources/local/student_helper.dart';
import 'package:aula_03_pos/models/student.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_student_page.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  final int? searchId;
  final String? searchName;
  final String? searchSurName;
  final String? searchRG;
  final String? searchCPF;
  final DateTime? searchBirthDate;
  final String? searchSex;
  const ListStudentPage(
      {this.searchId,
      this.searchName,
      this.searchSurName,
      this.searchRG,
      this.searchCPF,
      this.searchBirthDate,
      this.searchSex,
      Key? key})
      : super(key: key);
  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final _studentHelper = StudentHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alunos')),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.blue,
              onPressed: () => _openFormStudent(modeAction: "create"),
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
              onPressed: () => _openFormStudent(modeAction: "find"),
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
        future: _studentHelper.Find(
          widget.searchId,
          widget.searchName,
          widget.searchSurName,
          widget.searchRG,
          widget.searchCPF,
          widget.searchBirthDate,
          widget.searchSex,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Student>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Student> listaDados) {
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
                'Editar Alunos',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir Alunos',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _openFormStudent(
                    modeAction: "edit", student: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _studentHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Atenção',
                    textDesciption: 'Deseja excluir esse Aluno?',
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

  Widget _criarItemLista(Student student, int i) {
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
                  student.id.toString(),
                  style: const TextStyle(fontSize: 28),
                  textAlign: TextAlign.end,
                )),
            SizedBox(width: 10),
            SizedBox(
              width: 2,
              height: 60,
              child: const DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.black54)),
            ),
            SizedBox(
              width: 10,
              height: 60,
            ),
            Column(children: [
              Text(
                student.name!,
                style: const TextStyle(fontSize: 28),
                textAlign: TextAlign.start,
              ),
              Text(
                student.surName!,
                style: const TextStyle(fontSize: 28),
                textAlign: TextAlign.start,
              ),
            ])
          ]),
        ),
      ),
      //onTap: () => _openDetails(student),
      onLongPress: () => _openFormStudent(modeAction: "edit", student: student),
    );
  }

  void _openDetails(Student student) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BooksPage(student)));
  }

  void _openFormStudent({String? modeAction, Student? student}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadStudentPage(
                  modeAction: modeAction,
                  student: student,
                )));

    setState(() {});
  }
}
