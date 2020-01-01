import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/task.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/widgets/comboBox.dart';
import 'package:raporting_and_todo_app_mobile/widgets/daySelector.dart';
import 'package:raporting_and_todo_app_mobile/widgets/tasksList.dart';

class TasksPage extends StatefulWidget {
  TasksPageState createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {
  final List<String> users = List<String>();

  @override
  void initState() {
    users.add("User 1");
    users.add("User 2");
    users.add("User 3");
    users.add("User 4");
    users.add("User 5");
    super.initState();
  }

  Future<Task> _addTaskDialog(BuildContext context) async {
    String tmpUser = users.elementAt(0);
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
              ComboBox("Kto", tmpUser, users, (String newValue) {
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
                String id = await DatabaseService()
                .addTask(Task(id: null, user: tmpUser, date: tmpDate.toString().split(' ').elementAt(0), content: tmpContent));
                await DatabaseService().editTask(id: id);
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