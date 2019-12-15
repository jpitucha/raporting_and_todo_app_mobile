import 'package:flutter/material.dart';
import '../widgets/tile.dart';
import '../widgets/comboBox.dart';
import '../widgets/daySelector.dart';
import '../pack.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class ShippingPage extends StatefulWidget {
  ShippingPageState createState() => ShippingPageState();
}

class ShippingPageState extends State<ShippingPage> {
  final List<Pack> packages = List<Pack>();
  final List<String> companies = List<String>();
  final List<String> statuses = List<String>();
  String dropdownValue;

@override
  void initState() {
    packages.add(Pack("Company 1", DateTime.parse("2019-01-01 00:00:00.000"), "W trakcie"));
    packages.add(Pack("Company 2", DateTime.parse("2019-01-02 00:00:00.000"), "Oczekująca"));
    companies.add("Company 1");
    companies.add("Company 2");
    companies.add("Company 3");
    statuses.add("W trakcie");
    statuses.add("Oczekująca");
    super.initState();
  }

  Future<Pack> _editItemDialog(BuildContext context, Pack p) async {
    String newSender = p.sender;
    String newDate = p.date.toString().split(" ").elementAt(0);
    String newStatus = p.status;
    
    return showDialog<Pack>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edytuj paczuchę"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Nadawca: "),
                ComboBox(newSender, companies, (String newValue) {
                  setState(() {
                    newSender = newValue;
                  });
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Status:"),
                ComboBox(newStatus, statuses, (String newValue) {
                  setState(() {
                    newStatus = newValue;
                  });
                })
              ],
            ),
            DaySelector(DateTime.parse(newDate + " 00:00:00.000"), (DateTime dt) {
              newDate = dt.toString().split(" ").elementAt(0);
            })
          ]),
          actions: <Widget>[
            FlatButton(
              child: Text("ZAMKNIJ"),
              onPressed: () {
                Navigator.of(context).pop(Pack(p.sender, p.date, p.status));
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(Pack(newSender, DateTime.parse(newDate + " 00:00:00.000"), newStatus));
              },
            )
          ],
        );
      }
    );
  }

  Future<ConfirmAction> _deleteConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
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

Future<Pack> _addItemDialog(BuildContext context) async {
  String tmpCompany = companies.elementAt(0);
  String tmpStatus = statuses.elementAt(0);
  DateTime tmpDate = DateTime.now();
  return showDialog<Pack>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Dodaj paczuchę"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Nadawca:"),
                ComboBox(companies.elementAt(0), companies, (String newValue) {
                  if (newValue != null) {
                    tmpCompany = newValue;
                  }
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Status:"),
                ComboBox(statuses.elementAt(0), statuses, (String newValue) {
                  if (newValue != null) {
                    tmpStatus = newValue;
                  }
                })
              ],
            ),
            DaySelector(DateTime.now(), (DateTime newValue) {
              tmpDate = newValue;
            })
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text("ZAMKNIJ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(Pack(tmpCompany, tmpDate, tmpStatus));
              },
            )
        ],
      );
    }
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
          return Tile(packages[index].sender + " - " + packages.elementAt(index).date.toString().split(" ").elementAt(0), packages[index].status,
          () async {
            final Pack edited = await _editItemDialog(context, packages.elementAt(index));
            if (edited != packages[index]) {
              setState(() {
                packages[index] = edited;
              });
            }
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
        onPressed: () async {
          final newPack = await _addItemDialog(context);
          if (newPack.sender != null && newPack.date != null && newPack.status != null) {
            setState(() {
              packages.insert(0, newPack);
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}