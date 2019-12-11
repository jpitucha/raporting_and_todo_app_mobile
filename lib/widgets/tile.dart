import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String title;
  final String status;
  final VoidCallback onEditClicked;
  final VoidCallback onDeleteClicked;

  Tile(this.title, this.status, this.onEditClicked, this.onDeleteClicked);

  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: Text(
        widget.status,
        style: TextStyle(color: widget.status == 'W trakcie' ? Colors.green : Colors.red)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => widget.onEditClicked()),
          IconButton(icon: Icon(Icons.delete, color:Colors.red), onPressed: () => widget.onDeleteClicked()),
        ],
      ),
    );
  }
}