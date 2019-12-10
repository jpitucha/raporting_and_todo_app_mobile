import 'package:flutter/material.dart';

class RaportsPage extends StatefulWidget {
  RaportsPageState createState() => RaportsPageState();
}

class RaportsPageState extends State<RaportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raporty'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Raporty')
          ],
        ),
      )
    );
  }
}