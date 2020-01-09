import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/raport.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';
import 'package:raporting_and_todo_app_mobile/widgets/counterListTile.dart';
import 'package:raporting_and_todo_app_mobile/widgets/daySelector.dart';
import 'package:raporting_and_todo_app_mobile/widgets/raportsList.dart';

class RaportsPage extends StatefulWidget {
  RaportsPageState createState() => RaportsPageState();
}

class RaportsPageState extends State<RaportsPage> {
  Future<Raport> _addRaportDialog(BuildContext context) {
    DateTime tmpDate = DateTime.now();

    List<Map<String, dynamic>> tmpValues = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> values = List<Map<String, dynamic>>();

    Store().screens.forEach((el) => {
      tmpValues.add({
        'name': el.name + ' - ' + el.owner,
        'count': 0
      })
    });

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dodaj raport"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DaySelector(tmpDate, (DateTime newValue) {
                tmpDate = newValue;
              }),
              Container(
                height: 200,
                width: 300,
                child: ListView.builder(
                itemCount: Store().screens.length,
                itemBuilder: (BuildContext context, int index) {
                  return CounterListTile(name: Store().screens.elementAt(index).name
                  + ' - ' + Store().screens.elementAt(index).owner, onCountChanged: (int newValue) {
                    tmpValues.elementAt(index)['count'] = newValue;
                  },);
                },
              ),
              )
              
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
                bool dataAdded = false;
                for (int i = 0; i < tmpValues.length; i++) {
                  if (tmpValues.elementAt(i)['count'] > 0) {
                    dataAdded = true;
                    values.add(tmpValues.elementAt(i));
                    break;
                  }
                }
                if (dataAdded) {
                  String id = await DatabaseService().addRaport(Raport(id: null, user: Store().myName, date: tmpDate.toString().split(' ').elementAt(0), content: values.toString()));
                  await DatabaseService().editRaport(id: id);
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    DatabaseService().updateLocalScreens();

    return Scaffold(
      appBar: AppBar(
        title: Text('Raporty'),
      ),
      body: RaportsList(),
      floatingActionButton: Store().myRole == null || Store().myRole == 'user' ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => _addRaportDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}