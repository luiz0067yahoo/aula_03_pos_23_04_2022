import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class formPleople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.description,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.description,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Sobre Nome',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.badge,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'RG',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.badge,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'CPF',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.calendar_month,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Data Nacimento',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.wc,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Sexo',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
