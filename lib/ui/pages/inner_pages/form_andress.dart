import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class formAndress extends StatelessWidget {
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
              Icons.location_on,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'CEP',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          // Replace with a Row for horizontal icon + text
          children: [
            Icon(
              Icons.add_road,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Rua',
              ),
            )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.numbers,
            ),
            SizedBox(width: 10),
            new Flexible(
                child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Número',
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
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Compemento',
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
