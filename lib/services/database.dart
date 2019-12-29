import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
import '../models/pack.dart';

class DatabaseService {

  final CollectionReference sendersCollection = Firestore.instance.collection('senders');
  final CollectionReference shipmentsCollection  = Firestore.instance.collection('shipments');
  final CollectionReference tasksCollection = Firestore.instance.collection('tasks');

  Future<String> addTask(Task t) async {
    DocumentReference dr = await tasksCollection.add({
      'employee': t.employee,
      'date': t.date,
      'content': t.content
    });
    return dr.documentID;
  }

  Future editTask(Task t) async {
    await tasksCollection.document(t.id).setData({
      'employee': t.employee,
      'date': t.date,
      'content': t.content
    });
  }

  Future deleteTask(Task t) async {
    tasksCollection.document(t.id).delete();
  }

  Future<String> addShipment(Pack p) async {
    DocumentReference dr =  await shipmentsCollection.add({
      'sender': p.sender,
      'date': p.date,
      'status': p.status
    });
    return dr.documentID;
  }

  Future editShipment(Pack p) async {
    await shipmentsCollection.document(p.id).setData({
      'sender': p.sender,
      'date': p.date,
      'status': p.status
    });
  }

  Future deleteShipment(Pack p) async {
    await shipmentsCollection.document(p.id).delete();
  }
 
 }