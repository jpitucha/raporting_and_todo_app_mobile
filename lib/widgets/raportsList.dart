import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/models/raport.dart';
import 'package:raporting_and_todo_app_mobile/services/database.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';
import 'package:raporting_and_todo_app_mobile/shared/loading.dart';
import 'package:raporting_and_todo_app_mobile/widgets/counterListTile.dart';
import 'package:raporting_and_todo_app_mobile/widgets/daySelector.dart';
import 'package:raporting_and_todo_app_mobile/widgets/universalListTile.dart';

class RaportsList extends StatefulWidget {
  RaportsListState createState() => RaportsListState();
}

class RaportsListState extends State<RaportsList> {

  Future _infoRaportDialog(BuildContext context, Raport r) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Info"),
          content: Text(r.content, textAlign: TextAlign.justify,),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
  //TO DO add another screens from db
  Future<Raport> _editRaportDialog(BuildContext context, Raport r) {
    DateTime tmpDate = DateTime.parse(r.date + " 00:00:00.000");

    List<Map<String, dynamic>> tmpValues = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> stage2 = List<Map<String, dynamic>>();

    List<String> stage1 = r.content.substring(2, r.content.length-2).split('}, {');
    
    for (int i = 0; i < stage1.length; i++) {
      print(stage1.elementAt(i));
      stage2.add({
        'name': stage1.elementAt(i).split(', ').elementAt(0).substring(6),
        'count': stage1.elementAt(i).split(', ').elementAt(1).substring(7)
      });
    }

    Store().screens.forEach((el) => {
      tmpValues.add({
        'name': el.name + ' - ' + el.owner,
        'count': 0
      })
    });

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edytuj raport"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DaySelector(tmpDate, (DateTime newValue) {
                tmpDate = newValue;
              }),
              Container(
                height: 200,
                width: 300,
                child: ListView.builder(
                  itemCount: Store().screens.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CounterListTile(name: stage2.elementAt(index)['name'], count: int.parse(stage2.elementAt(index)['count']),
                    onCountChanged: (int newValue) {
                      stage2.elementAt(index)['count'] = newValue;
                  },);
                  },
                ),
              )
            ],
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
              onPressed: () {
                DatabaseService().editRaport(id: r.id, date: tmpDate.toString().split(' ').elementAt(0), content: stage2.toString());
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future _deleteRaportDialog(BuildContext context, Raport r) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Czy aby na pewno?"),
          content: Text('To spowoduje usunięcie elementu na zawsze'),
          actions: <Widget>[
            FlatButton(
              child: Text('ZAMKNIJ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                DatabaseService().deleteRaport(r);
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
    return StreamBuilder<List<Raport>>(
      stream: DatabaseService().raports,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Raport> data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return UniversalListTile(
                title: data.elementAt(index).user,
                subtitle: data.elementAt(index).date,
                renderInfoIconButton: true,
                renderEditDeleteIconButton: true,
                onInfoClicked: () => _infoRaportDialog(context, data.elementAt(index)),
                onEditClicked: () => _editRaportDialog(context, data.elementAt(index)),
                onDeleteClicked: () => _deleteRaportDialog(context, data.elementAt(index)),
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