import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/model/note.dart';
import '../main.dart';

class AuthService {

  AuthService.privateCon();
  static final AuthService instance = AuthService.privateCon();


  final user = FirebaseAuth.instance.currentUser;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  static QueryDocumentSnapshot? lastNote;
  static bool allLNotes = false;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');



  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    updateLoginStatus(false);
  }

  Future signUp(String email, String password, String userName,
      String confirmPassword) async {
    if (passwordConfirm(password, confirmPassword)) {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      addUser(userName, email);
    }
  }

  Future addUser(String userName, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'User Name': userName, 'Email': email});
  }

  bool passwordConfirm(String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

}
