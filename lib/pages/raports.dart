import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/raport.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';
import 'package:raporting_and_todo_app_mobile/widgets/counterListTile.dart';
import 'package:raporting_and_todo_app_mobile/widgets/daySelector.dart';

class RaportsPage extends StatefulWidget {
  RaportsPageState createState() => RaportsPageState();
}

class RaportsPageState extends State<RaportsPage> {
  Future<Raport> _addRaportDialog(BuildContext context) {
    DateTime tmpDate = DateTime.now();

    List<Map<String, dynamic>> values = List<Map<String, dynamic>>();

    Store().screens.forEach((el) => {
      values.add({
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
                    values.elementAt(index)['count'] = newValue;
                    print(values);
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
              onPressed: () {
                //db update
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
    DatabaseService().updateLocalScreens();

    return Scaffold(
      appBar: AppBar(
        title: Text('Raporty'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Raporty')
          ],
        ),
      ),
      floatingActionButton: Store().myRole == null || Store().myRole == 'user' ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => _addRaportDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}