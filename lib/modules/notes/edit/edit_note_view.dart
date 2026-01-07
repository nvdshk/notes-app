import 'package:flutter/material.dart';
import 'package:notes_app/modules/notes/edit/edit_note_form.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
    ),
    body: EditNoteForm(),
    );
  }
}