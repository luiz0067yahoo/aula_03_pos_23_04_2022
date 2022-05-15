import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String textDesciption;
  final TextInputType? teclado;

  const CustomTextField(
      {required this.controller,
      required this.textDesciption,
      this.teclado,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        keyboardType: teclado ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: textDesciption,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
