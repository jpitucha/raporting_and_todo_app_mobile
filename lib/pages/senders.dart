import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/sender.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/widgets/sendersList.dart';

class SendersPage extends StatefulWidget {
  SendersPageState createState() => SendersPageState();
}

class SendersPageState extends State<SendersPage>{

  Future<Sender> _addSenderDialog(BuildContext context) {
    String tmpName = '';

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dodaj nadawcę"),
          content: TextFormField(
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
                String id = await DatabaseService().addSender(Sender(id: null, name: tmpName));
                await DatabaseService().editSender(id: id);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Nadawcy"),
      ),
      body: SendersList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () => _addSenderDialog(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}