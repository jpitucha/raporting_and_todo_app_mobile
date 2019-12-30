import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:raporting_and_todo_app_mobile/services/auth.dart';
import 'package:raporting_and_todo_app_mobile/shared/loading.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  bool _remember = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('img/processor.png', height: 200.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isNotEmpty && value.contains('@') && value.contains('.')) {
                        return null;
                      } else {
                        return "Niepoprawny adres email";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Hasło'),
                    obscureText: true,
                    validator: (value) {
                      if (value.length >= 8) {
                        return null;
                      } else {
                        return "Hasło musi mieć przynajmniej 8 znaków";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _remember,
                        onChanged: (value) {
                          setState(() {
                            _remember = value;
                          });
                        },
                      ),
                      Text('Pamiętaj mnie')
                    ],
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text('ZALOGUJ'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
                        if (result == null) {
                          setState(() {
                            _loading = false;
                          });
                          print('Coś poszło nie tak');
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
