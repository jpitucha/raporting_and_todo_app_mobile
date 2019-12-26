import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/raports.dart';
import './pages/shipping.dart';
import './pages/tasks.dart';
import './pages/employees.dart';
import './pages/screens.dart';
import './pages/senders.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koordynacja serwisu',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        '/raports' : (context) => RaportsPage(),
        '/tasks' : (context) => TasksPage(),
        '/shipping' : (context) => ShippingPage(),
        '/employees' : (context) => EmployeesPage(),
        '/screens' : (context) => ScreensPage(),
        '/senders' : (context) => SendersPage()
      },
      //home: MyHomePage(title: 'Koordynacja serwisu'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Tile("Raporty", 'img/raport.png', 'routeTo'),
//             Tile("Zadania", 'img/staff.png', 'routeTo'),
//             Tile("Przesyłki", 'img/box.png', 'routeTo')
//           ],
//         ),
//       ),
//     );
//   }
// }