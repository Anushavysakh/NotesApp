import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/pages/home_pages/view_note.dart';
import 'package:notes_app/pages/home_pages/add_note.dart';
import 'package:notes_app/pages/home_pages/search_note.dart';
import 'package:notes_app/services/firebase_note_service.dart';
import 'package:notes_app/services/firebase_services.dart';
import 'package:notes_app/services/shared_preferences.dart';
import '../widgets/note_card.dart';
import 'home_pages/sidebar_menu_items/side_menubar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  List<Color> myColors = [
    Colors.orange.shade200,
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.deepPurple.shade200,
    Colors.purple.shade200,
    Colors.cyan.shade200,
    Colors.teal.shade200,
    Colors.tealAccent.shade200,
    Colors.pink.shade200,
  ];
  bool isGrid = false;
  int count = 1;
  bool isLight = true;
  bool isMoreData = true;

  SharedPreferenceApp pref = SharedPreferenceApp();
  ScrollController controller = ScrollController();

  final GlobalKey<ScaffoldState> _drawKey = GlobalKey();
  DocumentSnapshot? lastDocument;
  List<Note> noteList = [];

  bool loading = false;

  initialFetch() async {
    List<Note> list = await FirebaseNoteService.instance.initialFetch();
    setState(() {
      noteList = list;
      loading = false;
    });
  }

  fetchData() async {
    print("Fetch-data");
    List<Note> listMoreData = await FirebaseNoteService.instance.fetchMoreData() ;
    setState(() {
      noteList.addAll(listMoreData);
      loading = false;
    });
  }

  @override
  void initState() {
    updateStatus();

    super.initState();
    initialFetch();
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta && !loading) {
        print(loading);
        setState(() {
          loading = true;
        });
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  updateStatus() async {
    isGrid = await pref.getGridViewState();
    setState(() {
      isGrid ? count = 1 : count = 2;
    });
  }

  void _changeViewNotes() async {
    setState(() {
      isGrid = !isGrid;
      isGrid ? count = 1 : count = 2;
    });
    await SharedPreferenceApp.storeViewMode(isGrid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        endDrawerEnableOpenDragGesture: true,
        key: _drawKey,
        drawer:  SideBarMenu(),
        body: Column(
            children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(40)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        _drawKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SearchNotes(),
                        ));
                      },
                      child: const Text(
                        "Search your notes",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                  Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _changeViewNotes();
                              },
                              icon: const Icon(
                                Icons.grid_view_outlined,
                                size: 25,
                              )),
                          IconButton(
                              onPressed: signOut,
                              icon: const Icon(
                                Icons.logout,
                                size: 25,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // loading
          //     ? Expanded(
          //         flex: 9,
          //         child: Center(
          //           child: CircularProgressIndicator(),
          //         ))
          //    :
        Expanded(
                  flex: 9,
                  child: GridView.builder(
                    controller: controller,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: count,
                      childAspectRatio: 4 / 3,
                      // mainAxisSpacing: 2,
                      mainAxisExtent: 150,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      final Note note = noteList[index];
                      Random random = Random();
                      Color bg = myColors[random.nextInt(5)];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => ViewNote(note)
                          ))
                              .then((value) {
                            setState(() {});
                          });
                        },
                        onLongPress: (){

                        },
                        child: NoteCard(
                          bg: bg,
                          note: note,
                        ),
                      );
                    },
                  ),
                )
        ]),
        //
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => const AddNewNote(),
            ))
                .then(
              (value) {
                print("Calling Set State!");
                setState(() {});
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void signOut() {
    AuthService.instance.signOut();
  }
}
