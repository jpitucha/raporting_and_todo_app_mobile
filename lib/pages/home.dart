import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/services/auth.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';
import '../widgets/iconTile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    DatabaseService().updateLocalEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Zadania i raporty'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await storage.deleteAll();
                AuthService().signOut();
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "WITAJ!",
                      style: TextStyle(fontSize: 32.0),
                    ),
                    Text(
                      Store().myName ?? '',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_shipping),
                title: Text("Nadawcy"),
                onTap: () {
                  Navigator.pushNamed(context, '/senders');
                },
              ),
              ListTile(
                leading: Icon(Icons.picture_in_picture_alt),
                title: Text("Ekrany"),
                onTap: () {
                  Navigator.pushNamed(context, '/screens');
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Pracownicy"),
                onTap: () {
                  Navigator.pushNamed(context, '/employees');
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconTile("Raporty", 'img/raport.png', '/raports'),
              IconTile("Zadania", 'img/staff.png', '/tasks'),
              IconTile("Przesyłki", 'img/box.png', '/shipping')
            ],
          ),
        ));
  }
}
