import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/screen.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/widgets/comboBox.dart';
import 'package:raporting_and_todo_app_mobile/widgets/screensList.dart';

class ScreensPage extends StatefulWidget {
  ScreensPageState createState() => ScreensPageState();
}

class ScreensPageState extends State<ScreensPage> {
  List<String> pitches = List<String>();

  @override
  initState() {
    for (int i = 10; i <= 200; i++) {
      pitches.add('P ' + (i / 10.0).toString());
    }
    super.initState();
  }

  Future _addScreenDialog(BuildContext context) {
    String tmpPitch = pitches.elementAt(0);
    String tmpOwner = "Nadawca 1";

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Dodaj ekran"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ComboBox("Pitch", tmpPitch, pitches,
                    (String newValue) {
                  tmpPitch = newValue;
                }),
                ComboBox("Właściciel", tmpOwner,
                    ['Nadawca 1', 'Nadawca 2', 'Nadawca 3'], (String newValue) {
                  tmpOwner = newValue;
                })
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () async {
                  String id = await DatabaseService().addScreen(Screen(id: null, name: tmpPitch, owner: tmpOwner));
                  await DatabaseService().editScreen(id: id);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ekrany"),
      ),
      body: ScreensList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => _addScreenDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
