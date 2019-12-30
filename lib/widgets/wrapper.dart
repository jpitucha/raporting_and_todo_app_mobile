import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raporting_and_todo_app_mobile/services/auth.dart';
import '../models/user.dart';
import '../pages/login.dart';
import '../pages/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Wrapper extends StatelessWidget {
  final storage = FlutterSecureStorage();
  String email;
  String password;

  Future tryToLoginWithSavedCredentials() async {
    email = await storage.read(key: 'email');
    password = await storage.read(key: 'password');
    if (email.isNotEmpty && password.isNotEmpty) {
      AuthService().signInWithEmailAndPassword(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    tryToLoginWithSavedCredentials();

    return user == null ? LoginPage() : HomePage();
  }
}
