import 'package:aula_03_pos/datasources/local/professor_helper.dart';
import 'package:aula_03_pos/models/professor.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_professor_page.dart';
import 'package:flutter/material.dart';

class ListProfessor extends StatefulWidget {
  final int? searchId;
  final String? searchName;
  final String? searchSurName;
  final String? searchRG;
  final String? searchCPF;
  final DateTime? searchBirthDate;
  final String? searchSex;
  const ListProfessor(
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
  State<ListProfessor> createState() => _ListProfessorState();
}

class _ListProfessorState extends State<ListProfessor> {
  final _professorHelper = ProfessorHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Professores')),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.blue,
              onPressed: () => _openFormProfessor(modeAction: "create"),
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
              onPressed: () => _openFormProfessor(modeAction: "find"),
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
        future: _professorHelper.Find(
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
              return _criarLista(snapshot.data as List<Professor>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Professor> listaDados) {
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
                'Editar Professor',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir Professor',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _openFormProfessor(
                    modeAction: "edit", professor: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _professorHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Atenção',
                    textDesciption: 'Deseja excluir esse professor?',
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

  Widget _criarItemLista(Professor professor, int i) {
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
                  professor.id.toString(),
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
                professor.name!,
                style: const TextStyle(fontSize: 28),
                textAlign: TextAlign.start,
              ),
              Text(
                professor.surName!,
                style: const TextStyle(fontSize: 28),
                textAlign: TextAlign.start,
              ),
            ])
          ]),
        ),
      ),
      //onTap: () => _openDetails(professor),
      onLongPress: () =>
          _openFormProfessor(modeAction: "edit", professor: professor),
    );
  }

  void _openDetails(Professor professor) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BooksPage(professor)));
  }

  void _openFormProfessor({String? modeAction, Professor? professor}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadProfessorPage(
                  modeAction: modeAction,
                  professor: professor,
                )));

    setState(() {});
  }
}
