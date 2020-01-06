import 'package:raporting_and_todo_app_mobile/models/screen.dart';
import 'package:raporting_and_todo_app_mobile/models/sender.dart';

class Store {
  static final Store _instance = Store._internal();
  List<Screen> screens = List<Screen>();
  List<Sender> senders = List<Sender>();

  factory Store() {
    return _instance;
  }

  Store._internal();
}