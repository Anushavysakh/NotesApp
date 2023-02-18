import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/model/user.dart';
import '../main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthService {
  AuthService.privateCon();

  static final AuthService instance = AuthService.privateCon();
  final currentUser = FirebaseAuth.instance.currentUser;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  static QueryDocumentSnapshot? lastNote;
  static bool allLNotes = false;
  final userCollection = FirebaseFirestore.instance.collection('users');

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
      String confirmPassword, String image) async {
    if (passwordConfirm(password, confirmPassword)) {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      addUser(userName, email, image);
    }
  }

  Future addUser(String userName, String email, String image) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'User Name': userName, 'Email': email, 'Imageurl': image});
  }

  bool passwordConfirm(String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getUserName() async {
    var future = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    future.then((snapshot) {
      var data = snapshot.data();
      print('User name : ${data!['User Name']}');
    });
  }
}
