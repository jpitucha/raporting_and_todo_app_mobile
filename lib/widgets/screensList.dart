import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/screen.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';
import 'package:raporting_and_todo_app_mobile/shared/loading.dart';
import 'package:raporting_and_todo_app_mobile/widgets/comboBox.dart';
import 'package:raporting_and_todo_app_mobile/widgets/universalListTile.dart';

class ScreensList extends StatefulWidget {
  ScreensListState createState() => ScreensListState();
}

class ScreensListState extends State<ScreensList> {
  List<String> pitches = List<String>();

  @override
  initState() {
    for (int i = 10; i <= 200; i++) {
      pitches.add('P ' + (i / 10.0).toString());
    }
    super.initState();
  }

  Future _editScreenDialog(BuildContext context, Screen s) {
    String tmpName = s.name;
    String tmpOwner = s.owner;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edytuj ekran"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ComboBox("Pitch", tmpName, pitches, (String newValue) {
                tmpName = newValue;
              }),
              ComboBox("Właściciel", tmpOwner, Store().senders.map((s) => s.name).toList(), (String newValue) {
                tmpOwner = newValue;
              })
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("ZAMKNIJ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                DatabaseService().editScreen(id: s.id, name: tmpName, owner: tmpOwner);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future _deleteScreenDialog(BuildContext context, Screen s) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Czy aby na pewno?"),
          content: Text("To spowoduje usunięcie elementu na zawsze"),
          actions: <Widget>[
            FlatButton(
              child: Text("ZAMKNIJ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                DatabaseService().deleteScreen(s);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Screen>>(
      stream: DatabaseService().screens,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Screen> data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return UniversalListTile(
                title: data.elementAt(index).name,
                subtitle: data.elementAt(index).owner,
                renderInfoIconButton: false,
                renderEditDeleteIconButton: Store().myRole == 'admin' ? true : false,
                onEditClicked: () => _editScreenDialog(context, data.elementAt(index)),
                onDeleteClicked: () => _deleteScreenDialog(context, data.elementAt(index)),
              );
            },
          );
        } else {
          return Loading();
        }
      },
    );
  }
}