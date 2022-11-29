
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/pages/home_pages/sidebar_menu_items/notes.dart';
import 'package:uuid/uuid.dart';

import '../model/note.dart';

class FirebaseNoteService {
  static QueryDocumentSnapshot? lastNote;
  static bool allLNotes = false;

  Note? note;
  FirebaseNoteService.privateCon();

  static final FirebaseNoteService instance = FirebaseNoteService.privateCon();

  static addNote(String title, String description) async {
    String id = const Uuid().v4();
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');

    var data = {'title': title, 'contents': description, 'id': id};
    ref.add(data);
  }

  Future<void> delete(String id) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');
    final snapshot =
    await ref.where('id', isEqualTo: id).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> saveNote(Note note) async {
    CollectionReference reference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');
    final snapshot = await reference.where('id', isEqualTo: note.id).get();
    for (var doc in snapshot.docs) {
      var update = await doc.reference.update(
          {'title': note.title, 'contents': note.description});
    }
  }

  Future<List<Note>> initialFetch() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("notes");
    final snapshot = await ref.limit(5).get();
    if (snapshot.docs.isNotEmpty) {
      lastNote = snapshot.docs.last;
    }
    final notesList = snapshot.docs
        .map((document) => Note.fromDocumentsSnapshots(document))
        .toList();

    return notesList;
  }

  Future<List<Note>> fetchMoreData() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("notes");
    if (allLNotes == true) {
      return [];
    }
    if (lastNote == null) {
      return [];
    }
    final snapshot =
    await ref.orderBy('title').startAfterDocument(lastNote!).limit(5).get();


    final notesList = snapshot.docs
        .map((document) => Note.fromDocumentsSnapshots(document))
        .toList();

    if (snapshot.docs.length < 5) {
      allLNotes = true;
    }
    return notesList;
  }


}