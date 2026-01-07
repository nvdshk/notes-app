import 'package:flutter/material.dart';
import 'package:notes_app/modules/notes/add/add_note_form.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
    ),
    body: AddNoteForm(),
    );
  }
}