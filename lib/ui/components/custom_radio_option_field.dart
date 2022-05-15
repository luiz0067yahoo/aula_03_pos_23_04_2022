import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadioOptionField extends StatefulWidget {
  final TextEditingController controller;
  final String textDesciption;
  final int groupValue;
  final Map<String, String> keysValues;
  const CustomRadioOptionField(
      {required this.controller,
      required this.textDesciption,
      required this.groupValue,
      required this.keysValues,
      Key? key})
      : super(key: key);

  @override
  State<CustomRadioOptionField> createState() => _CustomRadioOptionFieldState();
}

class _CustomRadioOptionFieldState extends State<CustomRadioOptionField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          new Center(
            child: new Text(
              widget.textDesciption,
            ),
          ),
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.grey[50],
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: createRadioOptions(
                          controller: widget.controller,
                          keysValues: widget.keysValues,
                          groupValue: widget.groupValue),
                    )),
              ))
        ]));
  }

  ListTile createRadioOptionsItem(
      {required TextEditingController controller,
      required String key,
      required String value,
      required int groupValue}) {
    return ListTile(
      title: Text(key),
      leading: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (value) {
          setState(() {
            controller.text = value.toString();
          });
        },
        activeColor: Colors.green,
      ),
    );
  }

  List<ListTile> createRadioOptions(
      {required TextEditingController controller,
      required Map<String, String> keysValues,
      required int groupValue}) {
    List<ListTile> RadiosOpitions = [];
    keysValues.forEach((key, value) {
      RadiosOpitions.add(createRadioOptionsItem(
          controller: controller,
          key: key,
          value: value,
          groupValue: groupValue));
    });
    return RadiosOpitions;
  }
}
