import 'package:flutter/material.dart';

class EmployeesPage extends StatefulWidget {
  EmployeesPageState createState() => EmployeesPageState();
}

class EmployeesPageState extends State<EmployeesPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Pracownicy"),
      ),
      body: Text("data"),
    );
  }
}