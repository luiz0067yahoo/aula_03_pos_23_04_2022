import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart'; // ...
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CustomBasicDateField extends StatelessWidget {
  final String format;
  final TextEditingController controller;
  final String textDesciption;

  const CustomBasicDateField(
      {required this.controller,
      required this.format,
      required this.textDesciption,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cutomDateForrmat = new DateFormat(this.format);
    return Column(children: <Widget>[
      Text('${textDesciption} (${format})'),
      Padding(
          padding: const EdgeInsets.all(16),
          child: DateTimeField(
            decoration: InputDecoration(
              labelText: textDesciption,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
            format: cutomDateForrmat,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
            },
          )),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}
