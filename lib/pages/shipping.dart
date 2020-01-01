import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/widgets/shipmentsList.dart';
import '../widgets/shipmentTile.dart';
import '../widgets/comboBox.dart';
import '../widgets/daySelector.dart';
import '../models/pack.dart';

class ShippingPage extends StatefulWidget {
  ShippingPageState createState() => ShippingPageState();
}

class ShippingPageState extends State<ShippingPage> {
  final List<String> companies = List<String>();
  final List<String> statuses = List<String>();

  @override
  void initState() {
    companies.add("Company 1");
    companies.add("Company 2");
    companies.add("Company 3");
    statuses.add("W trakcie");
    statuses.add("Oczekująca");
    super.initState();
  }

  Future<Pack> _addShipmentDialog(BuildContext context) async {
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
                  String id = await DatabaseService()
                      .addShipment(Pack(id: null, sender: tmpSender, date: tmpDate, status: tmpStatus));
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
