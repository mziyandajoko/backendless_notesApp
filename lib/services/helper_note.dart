// ignore_for_file: use_build_context_synchronously

import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/services/note_service.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:assignment2_2022/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void refreshNotesInUI(BuildContext context) async {
  String result = await context.read<NoteService>().getNotes(
        context.read<UserService>().currentUser!.email,
      );
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Data successfully retrieved from the database.');
  }
}

void saveAllNotesInUI(BuildContext context) async {
  String result = await context
      .read<NoteService>()
      .saveNoteEntry(context.read<UserService>().currentUser!.email, true);
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Data successfully saved online!');
  }
}

void createNewNoteInUI(BuildContext context,
    {required TextEditingController titleController}) async {
  if (titleController.text.isEmpty) {
    showSnackBar(context, 'Please enter a note first, then save!');
  } else {
    Note note = Note(
      title: titleController.text.trim(),
      created: DateTime.now(),
    );
    if (context.read<NoteService>().notes.contains(note)) {
      showSnackBar(context, 'Duplicate value. Please try again.');
    } else {
      titleController.text = '';
      context.read<NoteService>().createNote(note);
      Navigator.pop(context);
    }
  }
}
