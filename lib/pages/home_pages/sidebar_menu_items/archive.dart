import 'package:flutter/material.dart';

import '../../../model/note.dart';

class Archive extends StatefulWidget {
  const Archive({
    Key? key,
  }) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List<Note> notes = [];
  List<Note> filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
