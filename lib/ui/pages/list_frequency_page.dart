import 'package:aula_03_pos/datasources/local/frequency_helper.dart';
import 'package:aula_03_pos/models/frequency.dart';
import 'package:aula_03_pos/ui/components/custom_message.dart';
import 'package:aula_03_pos/ui/pages/cad_frequency_page.dart';
import 'package:flutter/material.dart';

class ListFrequencyPage extends StatefulWidget {
  final int? searchId;
  final int? searchIdStudent;
  final int? searchIdClassAcademy;
  final int? searchIdSubject;
  final int? searchIdPhase;
  final int? searchValueFrequency;
  const ListFrequencyPage(
      {this.searchId,
      this.searchIdStudent,
      this.searchIdClassAcademy,
      this.searchIdSubject,
      this.searchIdPhase,
      this.searchValueFrequency,
      Key? key})
      : super(key: key);
  @override
  State<ListFrequencyPage> createState() => _ListFrequencyPageState();
}

class _ListFrequencyPageState extends State<ListFrequencyPage> {
  final _frequencyHelper = FrequencyHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Frequências')),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.blue,
              onPressed: () => _openFormFrequency(modeAction: "create"),
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
              onPressed: () => _openFormFrequency(modeAction: "find"),
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
        future: _frequencyHelper.Find(
          widget.searchId,
          widget.searchIdStudent,
          widget.searchIdClassAcademy,
          widget.searchIdStudent,
          widget.searchIdPhase,
          widget.searchValueFrequency,
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
              return _criarLista(snapshot.data as List<Frequency>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Frequency> listaDados) {
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
                _openFormFrequency(
                    modeAction: "edit", frequency: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _frequencyHelper.Delete(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await CustomMenssage.show(
                    context: context,
                    title: 'Atenção',
                    textDesciption: 'Deseja excluir essa frequency?',
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

  Widget _criarItemLista(Frequency frequency, int i) {
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
                    frequency.id.toString(),
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
                frequency.idStudent.toString(),
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
                frequency.idClassAcademy.toString(),
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
                frequency.idSubject.toString(),
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
                frequency.idPhase.toString(),
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
                frequency.valueFrequency.toString(),
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      //onTap: () => _openDetails(frequency),
      onLongPress: () =>
          _openFormFrequency(modeAction: "edit", frequency: frequency),
    );
  }

  void _openDetails(Frequency frequency) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BooksPage(frequency)));
  }

  void _openFormFrequency({String? modeAction, Frequency? frequency}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadFrequencyPage(
                  modeAction: modeAction,
                  frequency: frequency,
                )));

    setState(() {});
  }
}
