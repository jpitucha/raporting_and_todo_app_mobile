import 'package:firebase_auth/firebase_auth.dart';
import 'package:raporting_and_todo_app_mobile/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

    } catch (error) {
      print(error.toString());
    }
  }
}