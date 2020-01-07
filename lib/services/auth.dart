import 'package:firebase_auth/firebase_auth.dart';
import 'package:raporting_and_todo_app_mobile/models/user.dart';
import 'package:raporting_and_todo_app_mobile/services/store.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Employee _userFromFirebaseUser(FirebaseUser user) {
    if (user != null) {
      Store().myUID = user.uid;
    }
    return user != null ? Employee(id: user.uid) : null;
  }

  Stream<Employee> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}