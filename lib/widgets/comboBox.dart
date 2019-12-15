import 'package:flutter/material.dart';

class ComboBox extends StatefulWidget {
  String currentValue;
  List<String> values = List<String>();
  Function(String) onSelectionChange;

  ComboBox(this.currentValue, this.values, this.onSelectionChange);

  ComboBoxState createState() => ComboBoxState();
}

class ComboBoxState extends State<ComboBox> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.currentValue,
      onChanged: (String newValue) {
        setState(() {
          widget.currentValue = newValue;
          widget.onSelectionChange(newValue);
        });
      },
      items: widget.values.map((String value) {return DropdownMenuItem(value: value, child: Text(value));}).toList(),
    );
  }
}