import 'package:flutter/material.dart';

class ScreensPage extends StatefulWidget {
  ScreensPageState createState() => ScreensPageState();
}

class ScreensPageState extends State<ScreensPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Ekrany"),
      ),
      body: Text("data"),
    );
  }
}