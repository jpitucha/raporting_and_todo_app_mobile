import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raporting_and_todo_app_mobile/models/user.dart';
import 'package:raporting_and_todo_app_mobile/services/auth.dart';
import './pages/raports.dart';
import './pages/shipping.dart';
import './pages/tasks.dart';
import './pages/employees.dart';
import './pages/screens.dart';
import './pages/senders.dart';
import './pages/login.dart';
import './widgets/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Koordynacja serwisu',
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/raports': (context) => RaportsPage(),
          '/tasks': (context) => LoginPage(),
          '/shipping': (context) => ShippingPage(),
          '/employees': (context) => EmployeesPage(),
          '/screens': (context) => ScreensPage(),
          '/senders': (context) => SendersPage(),
        },
      ),
    );
  }
}