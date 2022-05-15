import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class formContact extends StatelessWidget {
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
              Icons.phone,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Telefone fixo',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.phone_android,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Celular',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.phonelink_ring,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Telefone recado',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.alternate_email,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'E-mail',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.apartment,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Cidade',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.map,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                //prefixIcon: Icon(Icons.key),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Estado',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
