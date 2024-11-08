import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authentication/model/user_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final userCollection =
      FirebaseFirestore.instance.collection('users').withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (value, options) => value.toFirestore(),
          );

  // get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in
  static Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // sign up
  static Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      // create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCollection.doc(userCredential.user!.uid).set(
            UserModel(userId: userCredential.user!.uid, email: email),
          );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  static Future<void> signOut() async {
    return await _auth.signOut();
  }
}
