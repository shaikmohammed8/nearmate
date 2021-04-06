import 'package:firebase_auth/firebase_auth.dart';
import 'package:nearmate/models/usermodel.dart';
import 'package:nearmate/service/firestore.dart';

class Authetication {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signup(
      {String email, String password, String name}) async {
    return await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (value != null) {
        FirestoreDB().adduser(UserModel(
            email: email,
            id: value.user.uid,
            name: name,
            deviceToken: '',
            photo: ''));
        return value;
      } else
        return value;
    });
  }

  Future<UserCredential> login({String email, String password}) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
