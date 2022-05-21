import 'package:aula_03_pos/datasources/local/report_card_helper.dart';
import 'package:aula_03_pos/models/report_card.dart';
import 'package:flutter/material.dart';

class ListReportCardPage extends StatefulWidget {
  int? searchIdStudent;
  int? searchIdClassAcademy;
  int? searchIdSubject;
  int? searchIdPhase;

  ListReportCardPage(
      {this.searchIdStudent,
      this.searchIdClassAcademy,
      this.searchIdSubject,
      Key? key})
      : super(key: key);
  @override
  State<ListReportCardPage> createState() => _ListReportCardPageState();
}

class _ListReportCardPageState extends State<ListReportCardPage> {
  final _reportCardHelper = ReportCardHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boletim')),
      body: FutureBuilder(
        future: _reportCardHelper.Find(widget.searchIdStudent),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _createList(snapshot.data as List<ReportCard>);
          }
        },
      ),
    );
  }

  Widget _createList(List<ReportCard> listaDados) {
    return ListView.builder(
        //padding: const EdgeInsets.all(4),
        itemCount: listaDados.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _createItemList(listaDados[index], index),
          );
        });
  }

  Widget _createItemList(ReportCard reportCard, int i) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(0.0),
        color:
            ((i % 2) != 0) ? Color.fromARGB(220, 220, 220, 220) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createHeader(reportCard, i),
              _createPhase(reportCard, i),
            ],
          ),
        ),
      ),
      //onTap: () => _openDetails(reportCard),
    );
  }

  Widget _createHeader(ReportCard reportCard, int i) {
    Widget _resultHeader =
        ((widget.searchIdClassAcademy == reportCard.idClassAcademy) &&
                (widget.searchIdStudent == reportCard.idStudent) &&
                (widget.searchIdSubject == reportCard.idSubject))
            ? SizedBox.shrink()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 30,
                      child: Text(
                        "Aluno: " +
                            (reportCard.nameStudent == null
                                ? ""
                                : reportCard.nameStudent!),
                        style: const TextStyle(fontSize: 28),
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(height: 10),
                  SizedBox(
                      height: 30,
                      child: Text(
                        "Disciplina: " +
                            (reportCard.nameSubject == null
                                ? ""
                                : reportCard.nameSubject!),
                        style: const TextStyle(fontSize: 28),
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(height: 10),
                  SizedBox(
                      height: 30,
                      child: Text(
                        (reportCard.namePhase == null
                            ? ""
                            : "Turma: " + reportCard.nameClassAcademy!),
                        style: const TextStyle(fontSize: 28),
                        textAlign: TextAlign.start,
                      )),
                ],
              );

    widget.searchIdClassAcademy = reportCard.idClassAcademy;
    widget.searchIdStudent = reportCard.idStudent;
    widget.searchIdSubject = reportCard.idSubject;
    return _resultHeader;
  }

  Widget _createPhase(ReportCard reportCard, int i) {
    print(widget.searchIdSubject.toString());
    Widget _resultHeader = (widget.searchIdPhase == reportCard.idPhase)
        ? SizedBox.shrink()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SizedBox(
                  height: 30,
                  child: Text(
                    (reportCard.namePhase == null
                        ? ""
                        : "Fase: " + reportCard.namePhase!),
                    style: const TextStyle(fontSize: 28),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      child: Text(
                    (reportCard.valueScorre == null
                        ? ""
                        : "Nota: " + reportCard.valueScorre!.toString()),
                    style: const TextStyle(fontSize: 28),
                    textAlign: TextAlign.start,
                  )),
                  SizedBox(height: 10),
                  SizedBox(
                      child: Text(
                    (reportCard.valueScorre == null
                        ? ""
                        : "Frequência: " +
                            reportCard.valueFrequency!.toString()),
                    style: const TextStyle(fontSize: 28),
                    textAlign: TextAlign.start,
                  )),
                  SizedBox(height: 10),
                ],
              )
            ],
          );

    widget.searchIdPhase = reportCard.idPhase;

    return _resultHeader;
  }
}
