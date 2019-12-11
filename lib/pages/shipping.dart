import 'package:flutter/material.dart';
import '../widgets/tile.dart';
import '../pack.dart';

class ShippingPage extends StatefulWidget {
  ShippingPageState createState() => ShippingPageState();
}

class ShippingPageState extends State<ShippingPage> {
  final List<Pack> packages = List<Pack>();

@override
  void initState() {
    packages.add(Pack("1", "W trakcie"));
    packages.add(Pack("2", "Oczekująca"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Przesyłki'),
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (BuildContext context, int index) {
          return Tile(packages[index].title, packages[index].status, () {}, () {setState(() { packages.removeAt(index); }); });
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}