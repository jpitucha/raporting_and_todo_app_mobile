import '../models/screen.dart';
import '../models/sender.dart';
import '../models/user.dart';

class Store {
  static final Store _instance = Store._internal();
  List<Screen> screens = List<Screen>();
  List<Sender> senders = List<Sender>();
  List<Employee> employees = List<Employee>();

  factory Store() {
    return _instance;
  }

  Store._internal();
}