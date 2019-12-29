import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import '../widgets/tile.dart';
import '../widgets/comboBox.dart';
import '../widgets/daySelector.dart';
import '../models/pack.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class ShippingPage extends StatefulWidget {
  ShippingPageState createState() => ShippingPageState();
}

class ShippingPageState extends State<ShippingPage> {
  final List<Pack> packages = List<Pack>();
  final List<String> companies = List<String>();
  final List<String> statuses = List<String>();

  @override
  void initState() {
    packages.add(Pack(
        "1", "Company 1", DateTime.parse("2019-01-01 00:00:00.000"), "W trakcie"));
    packages.add(Pack(
        "2", "Company 2", DateTime.parse("2019-01-02 00:00:00.000"), "Oczekująca"));
    companies.add("Company 1");
    companies.add("Company 2");
    companies.add("Company 3");
    statuses.add("W trakcie");
    statuses.add("Oczekująca");
    super.initState();
  }

  Future<Pack> _addItemDialog(BuildContext context) async {
    String tmpSender = companies.elementAt(0);
    String tmpStatus = statuses.elementAt(0);
    DateTime tmpDate = DateTime.now(); 

    return showDialog<Pack>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Dodaj przesyłkę"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ComboBox("Nadawca:", tmpSender, companies, (String newValue) {
                  if (newValue != null) {
                    tmpSender = newValue;
                  }
                }),
                ComboBox("Status:", tmpStatus, statuses, (String newValue) {
                  if (newValue != null) {
                    tmpStatus = newValue;
                  }
                }),
                DaySelector(tmpDate, (DateTime newValue) {
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
                onPressed: () async {
                  String id = await DatabaseService().addShipment(Pack(null, tmpSender, tmpDate, tmpStatus));
                  Navigator.of(context).pop(Pack(id, tmpSender, tmpDate, tmpStatus));
                },
              )
            ],
          );
        });
  }

  Future<Pack> _editItemDialog(BuildContext context, Pack p) async {
    String tmpSender = p.sender;
    String tmpDate = p.date.toString().split(" ").elementAt(0);
    String tmpStatus = p.status;

    return showDialog<Pack>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edytuj przesyłkę"),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ComboBox("Nadawca:", tmpSender, companies, (String newValue) {
                    setState(() {
                      tmpSender = newValue;
                    });
                  }),
              ComboBox("Status:", tmpStatus, statuses, (String newValue) {
                    setState(() {
                      tmpStatus = newValue;
                    });
                  }),
              DaySelector(DateTime.parse(tmpDate + " 00:00:00.000"),
                  (DateTime newValue) {
                tmpDate = newValue.toString().split(" ").elementAt(0);
              })
            ]),
            actions: <Widget>[
              FlatButton(
                child: Text("ZAMKNIJ"),
                onPressed: () {
                  Navigator.of(context).pop(Pack(p.id, p.sender, p.date, p.status));
                },
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  DatabaseService().editShipment(p);
                  Navigator.of(context).pop(Pack(p.id, tmpSender,
                      DateTime.parse(tmpDate + " 00:00:00.000"), tmpStatus));
                },
              )
            ],
          );
        });
  }

  Future<ConfirmAction> _deleteConfirmDialog(BuildContext context, Pack p) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Czy aby na pewno?'),
          content: const Text('To spowoduje usunięcie elementu na zawsze'),
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
                DatabaseService().deleteShipment(p);
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
            return Tile(
                packages[index].sender +
                    " - " +
                    packages
                        .elementAt(index)
                        .date
                        .toString()
                        .split(" ")
                        .elementAt(0),
                packages[index].status, () async {
              final Pack edited =
                  await _editItemDialog(context, packages.elementAt(index));
              if (edited != packages[index]) {
                setState(() {
                  packages[index] = edited;
                });
              }
            }, () async {
              final ConfirmAction choice = await _deleteConfirmDialog(context, packages.elementAt(index));
              if (choice == ConfirmAction.ACCEPT) {
                setState(() {
                  packages.removeAt(index);
                });
              }
            });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () async {
          final newPack = await _addItemDialog(context);
          if (newPack != null) {
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
