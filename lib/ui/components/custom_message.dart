import 'package:flutter/material.dart';

class CustomMenssage {
  static Future show(
      {required BuildContext context,
      required String title,
      required String textDesciption,
      required List<Widget> customButtons}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(textDesciption),
            actions: customButtons,
          );
        });
  }
}
