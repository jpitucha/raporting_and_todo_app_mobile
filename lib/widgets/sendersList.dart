import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/sender.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/shared/loading.dart';
import 'package:raporting_and_todo_app_mobile/widgets/senderTile.dart';

class SendersList extends StatefulWidget {
  SendersListState createState() => SendersListState();
}

class SendersListState extends State<SendersList> {

  Future _editSenderDialog(BuildContext context, Sender s) {
    String tmpName = s.name;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edytuj nadawcę"),
          content: TextFormField(
            initialValue: tmpName,
            onChanged: (String newValue) {
              tmpName = newValue;
            },
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nazwa'
            ),
              ),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () async {
                if (tmpName != s.name) {
                  await DatabaseService().editSender(id: s.id, name: tmpName);
                }
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future _deleteSenderDialog(BuildContext context, Sender s) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Czy aby na pewno?"),
          content: Text("To spowoduje usunięcie elementu na zawsze"),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                DatabaseService().deleteSender(s);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Sender>>(
      stream: DatabaseService().senders,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Sender> data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return SenderTile(
                name: data.elementAt(index).name,
                onEditClicked: () => _editSenderDialog(context, data.elementAt(index)),
                onDeleteClicked: () => _deleteSenderDialog(context, data.elementAt(index)),
              );
            },
          );
        } else {
          return Loading();
        }
      },
    );
  }
}