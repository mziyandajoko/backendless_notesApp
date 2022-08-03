Map<dynamic, dynamic> convertNoteListToMap(List<Note> notes) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < notes.length; i++) {
    map.addAll({'$i': notes[i].toJson()});
  }
  return map;
}

List<Note> convertMapToNoteList(Map<dynamic, dynamic> map) {
  List<Note> notes = [];
  for (var i = 0; i < map.length; i++) {
    notes.add(Note.fromJson(map['$i']));
  }
  return notes;
}

class Note {
  final String title;
  bool done;
  final DateTime created;

  Note({
    required this.title,
    this.done = false,
    required this.created,
  });

  Map<String, Object?> toJson() => {
        'title': title,
        'done': done ? 1 : 0,
        'created': created.millisecondsSinceEpoch,
      };

  static Note fromJson(Map<dynamic, dynamic>? json) => Note(
        title: json!['title'] as String,
        done: json['done'] == 1 ? true : false,
        created: DateTime.fromMillisecondsSinceEpoch(
            (json['created'] as double).toInt()),
      );

  @override
  bool operator ==(covariant Note note) {
    return (this.title.toUpperCase().compareTo(note.title.toUpperCase()) == 0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}
