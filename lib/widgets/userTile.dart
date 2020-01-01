import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  final String name;
  final String role;
  final VoidCallback onEditClicked;
  final VoidCallback onDeleteClicked;

  UserTile({this.name, this.role, this.onEditClicked, this.onDeleteClicked});

  UserTileState createState() => UserTileState();
}

class UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      subtitle: Text(widget.role),
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