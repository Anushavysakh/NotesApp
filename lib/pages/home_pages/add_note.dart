import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_pages/sidebar_menu_items/remainders.dart';
import 'package:notes_app/services/firebase_note_service.dart';

class AddNewNote extends StatefulWidget {
  const AddNewNote({super.key});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  String? titles;
  String? des;
  String? _alarmTimeString;
  bool isRemainder = false;
  DateTime? _alarmTime;

  void add() async {

      await FirebaseNoteService.addNote(titles!, des!);
      Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              setState(() {
                isRemainder = !isRemainder;
              });
              showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                clipBehavior: Clip.antiAlias,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setModalState) {
                      return Remainder();
                    },
                  );
                },
              );
            },
            icon: Icon(Icons.add_alert_rounded)),
        ElevatedButton(
            onPressed: add,
            child: const Text(
              "Save",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ))
      ]),
      body: Form(
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Title'),
            onChanged: (val) {
              titles = val;
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextFormField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(hintText: 'Notes'),
                onChanged: (val) {
                  des = val;
                },
              ),
            ),
          ),
          Container()
        ]),
      ),
    );
  }
}
