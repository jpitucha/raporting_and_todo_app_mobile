import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final String user;
  final String date;
  final String content;
  final VoidCallback onInfoClicked;
  final VoidCallback onEditClicked;
  final VoidCallback onDeleteClicked;

  TaskTile({this.user, this.date, this.content, this.onInfoClicked, this.onEditClicked, this.onDeleteClicked});

  TaskTileState createState() => TaskTileState();
}

class TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.user + " - " + widget.date),
      subtitle: Text(widget.content, maxLines: 1),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.info, color: Colors.lime),
            onPressed: () => widget.onInfoClicked()),
          IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => widget.onEditClicked()),
          IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => widget.onDeleteClicked()),
        ],
      )
    );
  }
}