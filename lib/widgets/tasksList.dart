import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/task.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/shared/loading.dart';
import 'package:raporting_and_todo_app_mobile/widgets/comboBox.dart';
import 'package:raporting_and_todo_app_mobile/widgets/daySelector.dart';
import 'package:raporting_and_todo_app_mobile/widgets/universalListTile.dart';

class TasksList extends StatefulWidget {
  TasksListState createState() => TasksListState();
}

class TasksListState extends State<TasksList> {
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

  Future _infoTaskDialog(BuildContext context, Task t) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Info"),
          content: Text(t.content, textAlign: TextAlign.justify,),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future<Task> _editTaskDialog(BuildContext context, Task t) async {
    String tmpUser = t.user;
    String tmpDate = t.date;
    String tmpContent = t.content;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edytuj zadanie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DaySelector(DateTime.parse(tmpDate + ' 00:00:00.000'), (DateTime newValue) {
                tmpDate = newValue.toString().split(' ').elementAt(0);
              }),
              ComboBox("Kto", tmpUser, users, (String newValue) {
                tmpUser = newValue;
              }),
              TextFormField(
                initialValue: tmpContent,
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
              onPressed: () {
                if (tmpUser != t.user) {
                  DatabaseService().editTask(id: t.id, user: tmpUser);
                }
                if (tmpDate != t.date) {
                  DatabaseService().editTask(id: t.id, date: tmpDate);
                }
                if (tmpContent != t.content) {
                  DatabaseService().editTask(id: t.id, content: tmpContent);
                }
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future _deleteTaskDialog(BuildContext context, Task t) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Czy aby na pewno?"),
          content: Text('To spowoduje usunięcie elementu na zawsze'),
          actions: <Widget>[
            FlatButton(
              child: Text('ZAMKNIJ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                DatabaseService().deleteTask(t);
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
    return StreamBuilder<List<Task>>(
      stream: DatabaseService().tasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Task> data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return UniversalListTile(
                title: data.elementAt(index).user + ' - ' + data.elementAt(index).date,
                subtitle: data.elementAt(index).content,
                renderInfoIconButton: true,
                onInfoClicked: () => _infoTaskDialog(context, data.elementAt(index)),
                onEditClicked: () => _editTaskDialog(context, data.elementAt(index)),
                onDeleteClicked: () => _deleteTaskDialog(context, data.elementAt(index)),
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