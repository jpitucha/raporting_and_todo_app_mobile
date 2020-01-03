import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raporting_and_todo_app_mobile/models/sender.dart';
import '../models/task.dart';
import '../models/pack.dart';
import '../models/user.dart';

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
  final CollectionReference employeesCollection =
      Firestore.instance.collection('employees');

  List<Pack> _packListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Pack(
          id: doc.data['id'],
          sender: doc.data['sender'],
          date: doc.data['date'],
          status: doc.data['status']);
    }).toList();
  }

  List<Employee> _employeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Employee(
        id: doc.data['id'],
        name: doc.data['name'],
        role: doc.data['role']
      );
    }).toList();
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task(
        id: doc.data['id'],
        user: doc.data['user'],
        date: doc.data['date'],
        content: doc.data['content']
      );
    }).toList();
  }

  List<Sender> _senderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Sender(
        id: doc.data['id'],
        name: doc.data['name'],
        address: doc.data['address']
      );
    }).toList();
  }

  Stream<List<Pack>> get shipments {
    return shipmentsCollection.snapshots().map(_packListFromSnapshot);
  }

  Stream<List<Employee>> get employees {
    return employeesCollection.snapshots().map(_employeeListFromSnapshot);
  }

  Stream<List<Task>> get tasks {
    return tasksCollection.snapshots().map(_taskListFromSnapshot);
  }

  Stream<List<Sender>> get senders {
    return sendersCollection.snapshots().map(_senderListFromSnapshot);
  }

  Future<String> addEmployee(Employee e) async {
    DocumentReference dr = await employeesCollection.add({
      'id': e.id,
      'name': e.name,
      'role': e.role 
    });
    return dr.documentID;
  }

  Future editEmployee({String id, String name = '', String role = ''}) async {
    if (name == '' && role == '') {
      await employeesCollection.document(id).updateData({'id': id});
    }
    if (name != '') {
      await employeesCollection.document(id).updateData({'name': name});
    }
    if (role != '') {
      await employeesCollection.document(id).updateData({'role': role});
    }
  }

  Future deleteEmployee(Employee e) async {
    await employeesCollection.document(e.id).delete();
  }

  Future<String> addSender(Sender s) async {
    DocumentReference dr = await sendersCollection.add({
      'id': s.id,
      'name': s.name,
      'address': s.address
    });
    return dr.documentID;
  }

  Future editSender({String id, String name = '', String address = ''}) async {
    if (name == '' && address == '') {
      await sendersCollection.document(id).updateData({'id': id});
    }
    if (name != '') {
      await sendersCollection.document(id).updateData({'name': name});
    }
    if (address != '') {
      await sendersCollection.document(id).updateData({'address': address});
    }
  }

  Future deleteSender(Sender s) async {
    await sendersCollection.document(s.id).delete();
  }

  Future<String> addTask(Task t) async {
    DocumentReference dr = await tasksCollection
        .add({'user': t.user, 'date': t.date, 'content': t.content});
    return dr.documentID;
  }

  Future editTask({String id, String user = '', String date = '', String content = ''}) async {
    if (user == '' && date == '' && content == '') {
      await tasksCollection.document(id).updateData({'id': id});
    }
    if (user != '') {
      await tasksCollection.document(id).updateData({'user': user});
    }
    if (date != '') {
      await tasksCollection.document(id).updateData({'date': date});
    }
    if (content != '') {
      await tasksCollection.document(id).updateData({'content': content});
    }
  }

  Future deleteTask(Task t) async {
    await tasksCollection.document(t.id).delete();
  }

  Future<String> addShipment(Pack p) async {
    DocumentReference dr = await shipmentsCollection
        .add({'sender': p.sender, 'date': p.date, 'status': p.status});
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
