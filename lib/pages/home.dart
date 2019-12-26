import 'package:flutter/material.dart';
import '../widgets/iconTile.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Koordynacja serwisu'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("CZEŚĆ", style: TextStyle(fontSize: 32.0),),
                  Text("JAKUB", style: TextStyle(fontSize: 26.0)),
                  Icon(Icons.person, size: 64.0,)
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
      )
    );
  }
}

