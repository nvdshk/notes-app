import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/constants/app_string_constants.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/modules/auth/login/login_controller.dart';
import 'package:notes_app/modules/notes/list/note_tile.dart';
import 'package:notes_app/modules/notes/list/notes_controller.dart';
import 'package:notes_app/routes/app_routes.dart';



class NotesView extends StatelessWidget {
   const NotesView({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.notes),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(AppRoutes.addNote);
              },
          ),
           IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {

             final controller =   Get.find<LoginController>();
              await controller.logout();
            },
          ),
        ],
        
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by title",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: Get.find<NotesController>().setSearch,
            ),
          ),
        ),
      ),
      body: GetBuilder<NotesController>(
    
      builder: (controller)  {
        final notes = controller.filteredNotes;

         if (controller.isLoading) {
          return Center(child: CircularProgressIndicator(),);
         }
         else if (notes.isEmpty){
           return Center(child: Text("No notes found"));
        }

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final NoteModel note = notes[index];
            return NoteTile(note: note, controller:  controller);
          },
        );
      }),
    );
  }
}