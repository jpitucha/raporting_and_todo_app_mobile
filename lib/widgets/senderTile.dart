import 'package:flutter/material.dart';

class SenderTile extends StatefulWidget {
  final String name;
  final VoidCallback onEditClicked;
  final VoidCallback onDeleteClicked;

  SenderTile({this.name, this.onEditClicked, this.onDeleteClicked});

  SenderTileState createState() => SenderTileState();
}

class SenderTileState extends State<SenderTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.blue,
            onPressed: () => widget.onEditClicked(),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => widget.onDeleteClicked(),
          )
        ],
      ),
    );
  }
}