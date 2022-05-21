import 'package:aula_03_pos/datasources/local/report_card_helper.dart';
import 'package:aula_03_pos/models/report_card.dart';
import 'package:flutter/material.dart';

class ListReportCardPage extends StatefulWidget {
  int? searchIdStudent;
  int? searchIdClassAcademy;
  int? searchIdSubject;
  int? searchIdPhase;
  int sumScore = 0;
  int countPhase = 0;
  int sumFrequenncy = 0;
  double avgScore = 0;
  double avgFrequenncy = 0;

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
    Widget _resultReportCard = ListView.builder(
        //padding: const EdgeInsets.all(4),
        itemCount: listaDados.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _createItemList(listaDados[index], index),
          );
        });
    return _resultReportCard;
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
              _createResult(reportCard),
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
                  SizedBox(height: 10),
                  SizedBox(
                    height: 3,
                    width: double.infinity,
                    child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.black54)),
                  ),
                ],
              );

    widget.searchIdClassAcademy = reportCard.idClassAcademy;
    widget.searchIdStudent = reportCard.idStudent;
    widget.searchIdSubject = reportCard.idSubject;
    return _resultHeader;
  }

  Widget _createPhase(ReportCard reportCard, int i) {
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

  Widget _createResult(ReportCard reportCard) {
    Widget _resulResult = SizedBox(
      height: 30,
      width: double.infinity,
      child: const DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black54)),
    ); //SizedBox.shrink();
    if ((widget.searchIdClassAcademy == reportCard.idClassAcademy) &&
        (widget.searchIdStudent == reportCard.idStudent) &&
        (widget.searchIdSubject == reportCard.idSubject)) {
      if ((reportCard != null) && (reportCard!.valueScorre != null))
        widget.sumScore = widget.sumScore + reportCard!.valueScorre!;
      if ((reportCard != null) && (reportCard!.valueFrequency != null))
        widget.sumScore = widget.sumScore + reportCard!.valueFrequency!;
      widget.countPhase++;
    } else {
      if ((widget.sumScore != 0) && (widget.countPhase != 0))
        widget.avgScore = widget.sumScore / widget.countPhase;
      else
        widget.avgScore = 0;
      if ((widget.sumFrequenncy != 0) && (widget.countPhase != 0))
        widget.avgFrequenncy = widget.sumFrequenncy / widget.countPhase;
      else
        widget.avgFrequenncy = 0;

      if ((widget.sumFrequenncy != 0) &&
          (widget.avgScore != 0) &&
          (widget.avgFrequenncy != 0)) {
        _resulResult = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SizedBox(
                height: 30,
                child: Text(
                  "Média  frequencia: " + widget.avgFrequenncy.toString(),
                  style: const TextStyle(fontSize: 28),
                  textAlign: TextAlign.start,
                )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    child: Text(
                  "Média Nota: " + widget.avgScore.toString(),
                  style: const TextStyle(fontSize: 28),
                  textAlign: TextAlign.start,
                )),
                SizedBox(height: 10),
                SizedBox(
                    child: Text(
                  "Média Frequência: " + widget.avgFrequenncy.toString(),
                  style: const TextStyle(fontSize: 28),
                  textAlign: TextAlign.start,
                )),
                SizedBox(height: 10),
              ],
            )
          ],
        );

        widget.sumFrequenncy = 0;
        widget.avgScore = 0;
        widget.avgFrequenncy = 0;
      }
    }
    return _resulResult;
  }
}
