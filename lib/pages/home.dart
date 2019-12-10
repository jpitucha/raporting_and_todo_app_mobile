import 'package:flutter/material.dart';
import '../widgets/tile.dart';

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
            Tile("Raporty", 'img/raport.png', '/raports'),
            Tile("Zadania", 'img/staff.png', '/tasks'),
            Tile("Przesyłki", 'img/box.png', '/shipping')
          ],
        ),
      )
    );
  }
}

