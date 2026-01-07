import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/data/models/user_model.dart';
import 'package:notes_app/data/services/database.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
        );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
       UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

        User? user = userCredential.user;
        if (user != null) {
   
        await Database().createNewUser(UserModel(id: user.uid, name: name, email: email));
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> logout() async => await _auth.signOut();

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found': return 'No user found with this email.';
      case 'wrong-password': return 'Wrong password.';
      case 'email-already-in-use': return 'Email already registered.';
      case 'invalid-email': return 'Invalid email address.';
      case 'weak-password': return 'Password is too weak.';
      default: return e.message ?? 'Authentication error';
    }
  }
}