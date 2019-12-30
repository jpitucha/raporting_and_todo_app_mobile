import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
import '../models/pack.dart';

class DatabaseService {
  final CollectionReference raportsCollection =
      Firestore.instance.collection('raports');
  final CollectionReference tasksCollection =
      Firestore.instance.collection('tasks');
  final CollectionReference shipmentsCollection =
      Firestore.instance.collection('shipments');

  final CollectionReference sendersCollection =
      Firestore.instance.collection('senders');
  final CollectionReference screensCollection =
      Firestore.instance.collection('screens');
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  List<Pack> _packListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Pack(
          id: doc.data['id'],
          sender: doc.data['sender'],
          date: DateTime.parse(doc.data['date'] + ' 00:00:00.000'),
          status: doc.data['status']);
    }).toList();
  }

  Stream<List<Pack>> get shipments {
    return shipmentsCollection.snapshots().map(_packListFromSnapshot);
  }

  Future<String> addTask(Task t) async {
    DocumentReference dr = await tasksCollection
        .add({'employee': t.employee, 'date': t.date, 'content': t.content});
    return dr.documentID;
  }

  Future editTask(Task t) async {
    await tasksCollection.document(t.id).setData(
        {'employee': t.employee, 'date': t.date, 'content': t.content});
  }

  Future deleteTask(Task t) async {
    tasksCollection.document(t.id).delete();
  }

  Future<String> addShipment(Pack p) async {
    DocumentReference dr = await shipmentsCollection
        .add({'sender': p.sender, 'date': p.date.toString().split(" ").elementAt(0), 'status': p.status});
    return dr.documentID;
  }

  Future editShipment({String id, String sender = '', String date = '', String status = ''}) async {
    if (sender == '' && date == '' && status == '') {
      await shipmentsCollection.document(id).updateData({'id': id});
    }
    if (sender != '') {
      await shipmentsCollection.document(id).updateData({'sender': sender});
    }
    if (date != '') {
      await shipmentsCollection.document(id).updateData({'date': date});
    }
    if (status != '') {
      await shipmentsCollection.document(id).updateData({'status': status});
    }
  }

  Future deleteShipment(Pack p) async {
    await shipmentsCollection.document(p.id).delete();
  }
}
