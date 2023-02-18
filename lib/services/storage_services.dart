import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:path/path.dart';

class StorageServices{

  File? _photo ;


  StorageServices(this._photo);

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'file/file';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/$fileName');
    } catch (e) {
      print('error occured');
    }

  }
  Future<String> getDownloadURL() async {

    if (_photo == null) return ' ';
    final fileName = basename(_photo!.path);
    final destination = 'file/file';
    try {
      return await storage
          .ref(destination)
          .child('file/$fileName')
          .getDownloadURL();
    } catch (e) {
      return "image not found !!!!!!!!!!!!";
    }
  }
}