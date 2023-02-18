import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_pages/sidebar_menu_items/remainders.dart';
import 'package:notes_app/services/firebase_services.dart';
import 'package:notes_app/services/image_upload.dart';
import '../../home_page.dart';
import 'archive.dart';
import 'about.dart';
import 'notes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({Key? key}) : super(key: key);

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String? userImage ;
  String userName = ' ';
final user = FirebaseFirestore.instance
    .collection('Users')
    .get();


Future<void> getProfileImage() async {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        userImage = value.data()!["Image"];
        print("Photo url:$userImage");
      });
    });
  }

  @override
  initState() {
    print(user);
    getProfileImage();
    super.initState();
    print("inside init - sidebar");
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    return Drawer(
        backgroundColor: Colors.grey,
        child: ListView(padding: const EdgeInsets.all(12), children: [
        DrawerHeader(
        child:
        Container(
        width: 30,
          height: 30,
          child: userImage != null
              ? CircleAvatar(
            radius: 64,

            backgroundImage: NetworkImage(userImage!),
          )
              : const Center(
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/user-picture.png'),
              backgroundColor: Colors.grey,
            ),
          ),
        ),),

        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
          child: rowWidget(
            icon: Icon(Icons.note),
            text: 'Notes',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Remainder(),
                ));
          },
          child: rowWidget(
              icon: Icon(Icons.notifications_active_outlined),
              text: 'Remainder'),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Archive(),
              ));
            },
            child: rowWidget(
                icon: Icon(Icons.archive_outlined), text: 'Archive')),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => About(),
              ));
            },
            child: rowWidget(
                icon: Icon(Icons.add_alert_rounded), text: 'About')),
        const SizedBox(
          height: 30,
        ),
        ]));
  }
}

Widget rowWidget({required Icon icon, required String text}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 26),
        )
      ]);
}
