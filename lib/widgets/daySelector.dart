import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  DateTime oldDate;
  final Function(DateTime) onSelectionChange;

  DaySelector(this.oldDate, this.onSelectionChange);

  DaySelectorState createState() => DaySelectorState();
}

Future<DateTime> _selectDate(BuildContext context, DateTime now) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: DateTime(2000),
    lastDate: DateTime(2050)
  );
  return picked;
}

class DaySelectorState extends State<DaySelector> {
  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(widget.oldDate.toString().split(" ").elementAt(0)),
        FlatButton(
        child: Text("ZMIEŃ"),
        onPressed: () async {
          final DateTime selected = await _selectDate(context, widget.oldDate);
          if (selected != null) {
            setState(() {
              widget.oldDate = selected;
              widget.onSelectionChange(selected);
            });
          }
        },
      )
      ],
    );
  }
}