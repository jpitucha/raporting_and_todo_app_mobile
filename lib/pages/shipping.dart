import 'package:flutter/material.dart';
import '../widgets/tile.dart';
import '../pack.dart';

enum ConfirmAction { CANCEL, ACCEPT }

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

  Future<ConfirmAction> _deleteConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Czy aby na pewno?'),
        content: const Text(
            'To spowoduje usunięcie elementu na zawsze'),
        actions: <Widget>[
          FlatButton(
            child: const Text('ZAMKNIJ'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
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
          return Tile(packages[index].title, packages[index].status,
          () {
            //edit
          },
          () async {
            final ConfirmAction choice = await _deleteConfirmDialog(context);
            if (choice == ConfirmAction.ACCEPT) {
              setState(() {
                packages.removeAt(index);
              });
            }
          });
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