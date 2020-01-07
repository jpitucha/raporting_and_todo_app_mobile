import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/task.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';
import 'package:raporting_and_todo_app_mobile/widgets/comboBox.dart';
import 'package:raporting_and_todo_app_mobile/widgets/daySelector.dart';
import 'package:raporting_and_todo_app_mobile/widgets/tasksList.dart';

class TasksPage extends StatefulWidget {
  TasksPageState createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {

  Future<Task> _addTaskDialog(BuildContext context) async {
    String tmpUser = Store().employees.elementAt(0).name;
    DateTime tmpDate = DateTime.now();
    String tmpContent = '';

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dodaj zadanie"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DaySelector(tmpDate, (DateTime newValue) {
                tmpDate = newValue;
              }),
              ComboBox("Kto", tmpUser, Store().employees.map((doc) => doc.name).toList(), (String newValue) {
                tmpUser = newValue;
              }),
              TextFormField(
                onChanged: (String newValue) {
                  tmpContent = newValue;
                },
                minLines: 2,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Treść'
                ),
              )
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
              onPressed: () async {
                if (tmpContent != '') {
                  String id = await DatabaseService()
                  .addTask(Task(id: null, user: tmpUser, date: tmpDate.toString().split(' ').elementAt(0), content: tmpContent));
                  await DatabaseService().editTask(id: id);
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
    DatabaseService().updateLocalEmployees();

    return Scaffold(
      appBar: AppBar(
        title: Text('Zadania'),
      ),
      body: TasksList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => _addTaskDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}