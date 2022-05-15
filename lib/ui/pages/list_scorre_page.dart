import 'package:aula_03_pos/datasources/local/scorre_helper.dart';
import 'package:aula_03_pos/models/scorre.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_scorre_page.dart';
import 'package:flutter/material.dart';

class ListScorre extends StatefulWidget {
  final int? searchId;
  final int? searchIdStudent;
  final int? searchIdClassAcademy;
  final int? searchIdSubject;
  final int? searchIdPhase;
  final int? searchValueScorre;
  const ListScorre(
      {this.searchId,
      this.searchIdStudent,
      this.searchIdClassAcademy,
      this.searchIdSubject,
      this.searchIdPhase,
      this.searchValueScorre,
      Key? key})
      : super(key: key);
  @override
  State<ListScorre> createState() => _ListScorreState();
}

class _ListScorreState extends State<ListScorre> {
  final _scorreHelper = ScorreHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas')),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.blue,
              onPressed: () => _openFormScorre(modeAction: "create"),
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
              onPressed: () => _openFormScorre(modeAction: "find"),
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
        future: _scorreHelper.Find(
          widget!.searchId!,
          widget!.searchIdStudent!,
          widget!.searchIdClassAcademy!,
          widget!.searchIdStudent!,
          widget!.searchIdPhase!,
          widget!.searchValueScorre!,
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
              return _criarLista(snapshot.data as List<Scorre>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Scorre> listaDados) {
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
                _openFormScorre(modeAction: "edit", scorre: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _scorreHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Atenção',
                    textDesciption: 'Deseja excluir essa scorre?',
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

  Widget _criarItemLista(Scorre scorre, int i) {
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
                    scorre.id.toString(),
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
                scorre.idStudent.toString(),
                style: const TextStyle(fontSize: 28),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 2,
                height: 30,
                child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black54)),
              ),
              SizedBox(width: 10),
              Text(
                scorre.idClassAcademy.toString(),
                style: const TextStyle(fontSize: 28),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 2,
                height: 30,
                child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black54)),
              ),
              SizedBox(width: 10),
              Text(
                scorre.idSubject.toString(),
                style: const TextStyle(fontSize: 28),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 2,
                height: 30,
                child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black54)),
              ),
              SizedBox(width: 10),
              Text(
                scorre.idPhase.toString(),
                style: const TextStyle(fontSize: 28),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 2,
                height: 30,
                child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black54)),
              ),
              SizedBox(width: 10),
              Text(
                scorre.valueScorre.toString(),
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      //onTap: () => _openDetails(scorre),
      onLongPress: () => _openFormScorre(modeAction: "edit", scorre: scorre),
    );
  }

  void _openDetails(Scorre scorre) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BooksPage(scorre)));
  }

  void _openFormScorre({String? modeAction, Scorre? scorre}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadScorrePage(
                  modeAction: modeAction,
                  scorre: scorre,
                )));

    setState(() {});
  }
}
