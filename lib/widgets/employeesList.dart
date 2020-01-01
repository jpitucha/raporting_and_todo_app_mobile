import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/user.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/shared/loading.dart';
import 'package:raporting_and_todo_app_mobile/widgets/comboBox.dart';
import 'package:raporting_and_todo_app_mobile/widgets/userTile.dart';

class EmployeesList extends StatefulWidget {
  EmployeesListState createState() => EmployeesListState();
}

Future<Employee> _editUserDialog(BuildContext context, Employee e) {
  String tmpRole = e.role;
  String tmpName = e.name;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Edytuj pracownika"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ComboBox("Rola", tmpRole, ['user', 'admin'], (String newValue) {
              tmpRole = newValue;
            }),
            TextFormField(
              initialValue: tmpName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nazwa'
              ),
              maxLines: 1,
              onChanged: (String newValue) {
                tmpName = newValue;
              },
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
              if (tmpRole != e.role) {
                DatabaseService().editEmployee(id: e.id, role: tmpRole);
              }
              if (tmpName != e.name) {
                DatabaseService().editEmployee(id: e.id, name: tmpName);
              }
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}

Future _deleteUserDialog(BuildContext context, Employee e) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Czy aby na pewno?"),
        content: Text('To spowoduje usunięcie elementu na zawsze'),
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
              DatabaseService().deleteEmployee(e);
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}

class EmployeesListState extends State<EmployeesList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Employee>>(
      stream: DatabaseService().employees,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Employee> data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return UserTile(
                name: data.elementAt(index).name,
                role: data.elementAt(index).role,
                onEditClicked: () => _editUserDialog(context, data.elementAt(index)),
                onDeleteClicked: () => _deleteUserDialog(context, data.elementAt(index)),
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