import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/user.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/widgets/comboBox.dart';
import 'package:raporting_and_todo_app_mobile/widgets/employeesList.dart';

class EmployeesPage extends StatefulWidget {
  EmployeesPageState createState() => EmployeesPageState();
}

class EmployeesPageState extends State<EmployeesPage>{
  String tmpRole = 'user';
  String tmpName = 'User';

  Future<Employee> _addUserDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dodaj użytkownika"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ComboBox("Rola", "user", ['user', 'admin'], (String newValue) {
                tmpRole = newValue;
              }),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nazwa'
                ),
                maxLines: 1,
                onChanged: (String newValue) {
                  tmpName = newValue;
                },
              ),
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
                String id = await DatabaseService().addEmployee(Employee(id: null, role: tmpRole, name: tmpName));
                await DatabaseService().editEmployee(id: id);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Pracownicy"),
      ),
      body: EmployeesList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => _addUserDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}