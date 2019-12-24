import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference sendersCollection = Firestore.instance.collection('senders');
  final CollectionReference shipmentsCollection  = Firestore.instance.collection('shipments');
  final CollectionReference tasksCollection = Firestore.instance.collection('tasks');

  Future<String> addTask(String employee, String date, String content) async {
    DocumentReference dr = await tasksCollection.add({
      'employee': employee,
      'date': date,
      'content': content
    });
    return dr.documentID;
  }

  Future editTask(String id, String employee, String date, String content) async {
    await tasksCollection.document(id).setData({
      'employee': employee,
      'date': date,
      'content': content
    });
  }

  Future deleteTask(String id) async {
    tasksCollection.document(id).delete();
  }

  Future<String> addShipment(String name, String date, String status) async {
    DocumentReference dr =  await shipmentsCollection.add({
      'name': name,
      'date': date,
      'status': status
    });
    return dr.documentID;
  }

  Future editShipment(String id, String name, String date, String status) async {
    await shipmentsCollection.document(id).setData({
      'name': name,
      'date': date,
      'status': status
    });
  }

  Future deleteShipment(String id) async {
    await shipmentsCollection.document(id).delete();
  }
 }