import 'package:flutter/material.dart';

class UniversalListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool renderInfoIconButton;
  final VoidCallback onInfoClicked;
  final VoidCallback onEditClicked;
  final VoidCallback onDeleteClicked;

  UniversalListTile({this.title, this.renderInfoIconButton, this.onEditClicked, this.onDeleteClicked, this.subtitle, this.onInfoClicked});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle ?? ''),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !renderInfoIconButton ? Container() : IconButton(
            icon: Icon(Icons.info),
            color: Colors.yellow,
            onPressed: () => onInfoClicked()
          ),
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.blue,
            onPressed: () => onEditClicked(),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => onDeleteClicked(),
          )
        ],
      ),
    );
  }
}