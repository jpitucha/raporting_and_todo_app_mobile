import 'package:flutter/material.dart';

class ShippingPage extends StatefulWidget {
  ShippingPageState createState() => ShippingPageState();
}

class ShippingPageState extends State<ShippingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Przesyłki'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('01.12.2019 - CMA'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('02.12.2019 - CMA'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('03.12.2019 - BerryLife'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('04.12.2019 - CMA'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('05.12.2019 - Piloci'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('06.12.2019 - Galicja'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('07.12.2019 - Galicja'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('08.12.2019 - CMA'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('09.12.2019 - Twój Event'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('10.12.2019 - CMA'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('01.12.2019 - CMA'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('02.12.2019 - CMA'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('03.12.2019 - BerryLife'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('04.12.2019 - CMA'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('05.12.2019 - Piloci'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('06.12.2019 - Galicja'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('07.12.2019 - Galicja'),
            subtitle: Text("Oczekująca", style: TextStyle(color: Colors.red))
          ),
          ListTile(
            title: Text('08.12.2019 - CMA'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('09.12.2019 - Twój Event'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          ),
          ListTile(
            title: Text('10.12.2019 - CMA'),
            subtitle: Text("W trakcie", style: TextStyle(color: Colors.green))
          )
        ],
      )
    );
  }
}