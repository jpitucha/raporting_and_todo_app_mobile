import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/shared/loading.dart';
import '../models/pack.dart';
import '../widgets/shipmentTile.dart';
import '../services/database.dart';
import '../widgets/comboBox.dart';
import '../widgets/daySelector.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class ShipmentsList extends StatefulWidget {
  ShipmentsListState createState() => ShipmentsListState();
}

class ShipmentsListState extends State<ShipmentsList> {

  Future<Pack> _editShipmentDialog(BuildContext context, Pack p) async {
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
              ComboBox("Nadawca:", tmpSender, ['Company 1', 'Company 2', 'Company 3'], (String newValue) {
                setState(() {
                  tmpSender = newValue;
                });
              }),
              ComboBox("Status:", tmpStatus, ['W trakcie', 'Oczekująca'], (String newValue) {
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
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  if (tmpSender != p.sender) {
                    DatabaseService().editShipment(id: p.id, sender: tmpSender);
                  }
                  if (tmpDate != p.date.toString().split(" ").elementAt(0)) {
                    DatabaseService().editShipment(id: p.id, date: tmpDate);
                  }
                  if (tmpStatus != p.status) {
                    DatabaseService().editShipment(id: p.id, status: tmpStatus);
                  }
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<ConfirmAction> _deleteShipmentDialog(BuildContext context, Pack p) async {
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
    return StreamBuilder<List<Pack>>(
      stream: DatabaseService().shipments,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Pack> data = snapshot.data;
          return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ShipmentTile(
                data.elementAt(index).sender +
                    " - " + data
                          .elementAt(index)
                          .date
                          .toString()
                          .split(" ")
                          .elementAt(0),
                  data.elementAt(index).status,
                  () => _editShipmentDialog(context, data.elementAt(index)),
                  () => _deleteShipmentDialog(context, data.elementAt(index)));
            });
        } else {
          return Loading();
        }
      },
    );
  }
}