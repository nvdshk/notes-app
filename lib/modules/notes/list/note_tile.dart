import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/modules/notes/list/notes_controller.dart';
import 'package:notes_app/routes/app_routes.dart';

class NoteTile extends StatelessWidget {
  final NoteModel note;
  final NotesController controller;

  const NoteTile( {super.key, required this.note, required this.controller} );

  @override
  Widget build(BuildContext context) {
    return Card(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                title: Text(note.title, maxLines: 1,),
                subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis,),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.toNamed(
                        AppRoutes.editNote,
                        arguments: note,
                      );},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => controller.deleteNote(note.id),
                    ),
                  ],
                ),
              ),
            ); 
  }
}