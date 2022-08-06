import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/models/noteEntry.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

class NoteService with ChangeNotifier {
  NoteEntry? _noteEntry;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void emptyNotes() {
    _notes = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  Future<String> getNotes(String username) async {
    String result = 'OK';
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";

    _busyRetrieving = true;
    notifyListeners();

    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('NoteEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (result != 'OK') {
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }

    if (map != null) {
      if (map.length > 0) {
        _noteEntry = NoteEntry.fromJson(map.first);
        _notes = convertMapToNoteList(_noteEntry!.notes);
        notifyListeners();
      } else {
        emptyNotes();
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

  Future<String> saveNoteEntry(String username, bool inUI) async {
    String result = 'OK';
    if (_noteEntry == null) {
      _noteEntry =
          NoteEntry(notes: convertNoteListToMap(_notes), username: username);
    } else {
      _noteEntry!.notes = convertNoteListToMap(_notes);
    }

    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }
    await Backendless.data
        .of('NoteEntry')
        .save(_noteEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });
    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }

    return result;
  }

  void toggleNoteDone(int index) {
    _notes[index].done = !_notes[index].done;
    notifyListeners();
    //setUIStateFlag(UIState.CHANGED);
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
    // setUIStateFlag(UIState.CHANGED);
  }

  void createNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
    // setUIStateFlag(UIState.CHANGED);
  }
}
