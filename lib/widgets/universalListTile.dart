import 'package:flutter/material.dart';

class UniversalListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool renderInfoIconButton;
  final bool renderEditDeleteIconButton;
  final VoidCallback onInfoClicked;
  final VoidCallback onEditClicked;
  final VoidCallback onDeleteClicked;

  UniversalListTile({this.title, this.renderInfoIconButton, this.renderEditDeleteIconButton, this.onEditClicked, this.onDeleteClicked, this.subtitle, this.onInfoClicked});

  @override
  Widget build(BuildContext context) {
    Color subtitleColor;
    if (subtitle == 'W trakcie') {
      subtitleColor = Colors.green;
    } else if (subtitle == 'Oczekująca') {
      subtitleColor = Colors.red;
    } else {
      subtitleColor = Colors.white70;
    }
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle ?? '', style: TextStyle(color: subtitleColor), maxLines: 1,),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !renderInfoIconButton ? Container() : IconButton(
            icon: Icon(Icons.info),
            color: Colors.yellow,
            onPressed: () => onInfoClicked()
          ),
          !renderEditDeleteIconButton ? Container() : IconButton(
            icon: Icon(Icons.edit),
            color: Colors.blue,
            onPressed: () => onEditClicked(),
          ),
          !renderEditDeleteIconButton ? Container() : IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => onDeleteClicked(),
          )
        ],
      ),
    );
  }
}