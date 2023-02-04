import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_pages/view_note.dart';
import 'package:notes_app/services/firebase_note_service.dart';

import '../model/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.bg,
    required this.note,
  }) : super(key: key);

  final Color bg;
  final Note note;

  @override
  Widget build(BuildContext context) {
    //print(note.created.toString());
    return Card(
        margin: const EdgeInsets.all(10),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        color: bg,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              TextButton(
                onLongPress: () {

                  print("long press options");
                },
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  ViewNote(note),
                  ));
                },
                child: Text(note.title ?? " ",
                // data!['title'],
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black45,
                ),
              ),
              // data!['title'],
            ),

          //    Text(note.created.toString())
          ]),
        ));
  }
}
