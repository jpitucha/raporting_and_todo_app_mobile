import 'package:flutter/material.dart';

class ComboBox extends StatefulWidget {
  String title;
  String currentValue;
  List<String> values = List<String>();
  Function(String) onSelectionChange;

  ComboBox(this.title, this.currentValue, this.values, this.onSelectionChange);

  ComboBoxState createState() => ComboBoxState();
}

class ComboBoxState extends State<ComboBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Status:"),
        DropdownButton(
          value: widget.currentValue,
          onChanged: (String newValue) {
            setState(() {
              widget.currentValue = newValue;
              widget.onSelectionChange(newValue);
            });
          },
          items: widget.values.map((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
        )
      ],
    );
  }
}
