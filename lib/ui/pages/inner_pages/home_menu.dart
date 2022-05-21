import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/phase")},
          color: Colors.grey,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.reduce_capacity, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Fase",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/class_academy")},
          color: Colors.blueGrey,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.reduce_capacity, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Turma ",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/subject")},
          color: Colors.grey,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Disciplinas",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/professor")},
          color: Colors.black87,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.school, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Cadastro Professores",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {
            Navigator.of(context).pushNamed("/class_academy_suject_professor")
          },
          color: Colors.grey[850],
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.polyline, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Diciplina Turma professor",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/student")},
          color: Colors.teal,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.local_library, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Cadastro Alunos",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {
            Navigator.of(context).pushNamed("/class_academy_suject_student")
          },
          color: Colors.teal[400],
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.polyline, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Diciplina Turma Aluno",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/frequency")},
          color: Colors.blue[900],
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.checklist_rtl, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Frequência",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/scorre")},
          color: Colors.blue,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.poll, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Notas",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        FlatButton(
          onPressed: () => {Navigator.of(context).pushNamed("/report_card")},
          color: Colors.blue,
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.poll, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Boletim",
                style: TextStyle(color: Colors.white, fontSize: 28),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
