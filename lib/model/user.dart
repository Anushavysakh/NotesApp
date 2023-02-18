import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:notes_app/services/firebase_services.dart';

class UserModel  {
  String id;
  String url;
  String userName;
  String email;
  String password;

  UserModel(this.id, this.url, this.userName, this.email, this.password);

  static UserModel fromDocumentsSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> e) {
    return UserModel(
        e['id'], e['User Name'], e['Imageurl'], e['Email'], e['Password']);
  }

  static UserModel fromMap(Map map) {
    return UserModel(map['id'], map['User Name'], map['Email'], map['Imageurl'],
        map['Password']);
  }

  static UserModel fromDocumentsSnapshots(QueryDocumentSnapshot<Object?> e) {
    return UserModel(e['id'], e['User Name'], e['Imageurl'], e['Email'],e['Password']);
  }
}
