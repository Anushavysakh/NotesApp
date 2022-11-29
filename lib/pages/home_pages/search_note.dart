import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'view_note.dart';
import '../../model/note.dart';

class SearchNotes extends StatefulWidget {
  const SearchNotes({Key? key}) : super(key: key);

  @override
  State<SearchNotes> createState() => _SearchNotesState();
}

class _SearchNotesState extends State<SearchNotes> {

  Future<QuerySnapshot>? postDocumentLists;
  String searchTitle = ' ';

  List<Note> notes = [];
  List<Note> filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  fetchNotes() async {
    final notesDocuments = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes')
        .get();

    notes =
        notesDocuments.docs.map((e) => Note.fromDocumentsSnapshot(e)).toList();
  }

  initSearchingNotes(String textEntered) {
    filteredList =
        notes.where((note) => note.title!.contains(textEntered)).toList();

    setState(() {});
  }

  final user = FirebaseAuth.instance.currentUser;
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  // initSearchingNotes(searchTitle);
                },
                icon: const Icon(Icons.search),
              ),
              hintText: 'Search...'),
          onChanged: (textEntered) {
            initSearchingNotes(textEntered);
            // setState(() {
            //   searchTitle = textEntered;
            // });
          },
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            final note = filteredList[index];
            return Card(
                margin: const EdgeInsets.all(22),
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                // color: bg,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Text(
                        note.title ?? " ",
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ));
          },
          itemCount: filteredList.length),
    );
  }
}
