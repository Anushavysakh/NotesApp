import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Note {
  var id = const Uuid().v4();
  String? title;
  String? description;
 // Timestamp? created;

  Note(this.id, this.title, this.description);

  static Note fromDocumentsSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> e) {
    return Note(e['id'], e['title'], e['contents'],);
  }

  static Note fromMap(Map map) {
    return Note(map['id'], map['title'], map['contents'],);
  }

  static Note fromDocumentsSnapshots(QueryDocumentSnapshot<Object?> e) {
    return Note(e['id'], e['title'], e['contents'],);
  }

  // Note.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'];
  // }
  //
  // Map<String, dynamic> toMap() => {
  //   "id": id,
  //   "title": title,
  //   "contents": description,
  //
  // };

}
