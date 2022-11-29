import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_pages/sidebar_menu_items/remainders.dart';
import 'package:notes_app/pages/home_pages/sidebar_menu_items/trash.dart';
import '../../home_page.dart';
import 'add.dart';
import 'archive.dart';
import 'create_new_label.dart';
import 'help_feedback.dart';
import 'notes.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey,
        child: ListView(children: [
          DrawerHeader(
              child: Text(
            "Google Keep",
            style: TextStyle(fontSize: 32, color: Colors.white),
          )),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.lightbulb),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    " Notes",
                    style: TextStyle(fontSize: 26),
                  )
                ]),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  Remainder(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_alert_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      " Remainders",
                      style: TextStyle(fontSize: 26),
                    )
                  ]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Add(),
          SizedBox(
            height: 30,
          ),
          Archive(),
          SizedBox(
            height: 30,
          ),
          Trash(),
          SizedBox(
            height: 30,
          ),
          Settings(),
          SizedBox(
            height: 30,
          ),
          HelpAndFeedback(),
          SizedBox(
            height: 30,
          ),
        ]));
  }
}

//IconButton(
// onPressed: () {
// _drawKey.currentState!.openDrawer();
// },
// icon: const Icon(Icons.menu)),
