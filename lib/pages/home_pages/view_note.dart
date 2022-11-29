import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/pages/home_pages/sidebar_menu_items/remainders.dart';
import 'package:notes_app/services/firebase_note_service.dart';

class ViewNote extends StatefulWidget {
  final Note note;

  ViewNote(this.note);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String? title;
  String? des;

  bool edit = true;
  bool isDelete = true;

  bool addRemainder = false;
  Remainder remainder = Remainder();

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.note.title;
    des = widget.note.description;
    return Scaffold(
        appBar: AppBar(actions: [
          ElevatedButton(
              onPressed: () {
                edit = !edit;
              },
              child: const Icon(Icons.edit)),
          ElevatedButton(onPressed: () {
            addRemainder = !addRemainder;
            showModalBottomSheet(context: context, builder: (context) {
              return Remainder();
            },);
          }, child: Icon(Icons.notification_add)),
          ElevatedButton(
              onPressed: () {

                setState(() {
                  FirebaseNoteService.instance.saveNote(widget.note);
                  title = widget.note.title;
                  des = widget.note.description;
                });
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.save_rounded)),
          ElevatedButton(
              onPressed: () {
                {
                  setState(() {
                    FirebaseNoteService.instance.delete(widget.note.id);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.delete))
        ]),
        body: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic),
                    initialValue: title,
                    enabled: edit,
                    onChanged: (val) {
                      title = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Can't be empty !";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Notes', border: InputBorder.none),
                      initialValue: des,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                      enabled: edit,
                      onChanged: (val) {
                        des = val;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Can't be empty !";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  edit ? (addRemainder ? Container(child: Row(
                    children: [
                      Icon(Icons.notification_important_outlined),Text(remainder.toString())
                    ],
                  ),) : Container()): Container(),
                ]),
          ),
        ));
  }
}
