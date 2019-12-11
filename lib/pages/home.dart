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

