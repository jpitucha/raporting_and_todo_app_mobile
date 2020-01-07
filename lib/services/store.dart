import '../models/screen.dart';
import '../models/sender.dart';
import '../models/user.dart';

class Store {
  static final Store _instance = Store._internal();
  List<Screen> screens = List<Screen>();
  List<Sender> senders = List<Sender>();
  List<Employee> employees = List<Employee>();
  String myUID;
  String myName;
  String myRole;

  void getMyInfo() {
    for (int i = 0; i < employees.length; i++) {
      if (employees.elementAt(i).id == myUID) {
        myName = employees.elementAt(i).name;
        myRole = employees.elementAt(i).role;
      }
    }
  }

  factory Store() {
    return _instance;
  }

  Store._internal();
}