import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';
import 'package:raporting_and_todo_app_mobile/widgets/shipmentsList.dart';
import '../widgets/comboBox.dart';
import '../widgets/daySelector.dart';
import '../models/pack.dart';

class ShippingPage extends StatefulWidget {
  ShippingPageState createState() => ShippingPageState();
}

class ShippingPageState extends State<ShippingPage> {
  final List<String> statuses = List<String>();

  @override
  void initState() {
    statuses.add("W trakcie");
    statuses.add("Oczekująca");
    super.initState();
  }

  Future<Pack> _addShipmentDialog(BuildContext context) async {
    String tmpSender = Store().senders.elementAt(0).name;
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
                ComboBox("Nadawca:", tmpSender, Store().senders.map((s) => s.name).toList(), (String newValue) {
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
                  String id = await DatabaseService()
                      .addShipment(Pack(id: null, sender: tmpSender, date: tmpDate.toString().split(' ').elementAt(0), status: tmpStatus));
                  await DatabaseService().editShipment(id: id);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService().updateLocalSenders();

    return Scaffold(
        appBar: AppBar(
          title: Text('Przesyłki'),
        ),
        body: ShipmentsList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () => _addShipmentDialog(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}
