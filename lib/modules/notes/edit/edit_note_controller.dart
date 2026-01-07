import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/constants/app_string_constants.dart';
import 'package:notes_app/core/widgets/custom_snackbar.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/data/repositories/notes_repository.dart';

class EditNoteController extends GetxController {

  final NotesRepository _repository = NotesRepository();
  final NoteModel note = Get.arguments;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isLoading = false;


  clear(){
    titleController.clear();
    contentController.clear();
  }

  @override
  void onInit() {
     titleController.text = note.title;
    contentController.text = note.content;
    super.onInit();
  }
  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
  }


 bool _isValid() {
   if (titleController.text.trim().isEmpty) {
      CustomSnackBar.showError(
        context: Get.context,
        title: AppString.error,
        message: AppString.enterTitle,
      );
      return false;
    }
    if (contentController.text.trim().isEmpty) {
      CustomSnackBar.showError(
        context: Get.context,
        title: AppString.error,
        message: AppString.enterContent,
      );
      return false;
    }
    return true;
  }

  

 Future<void> editNote() async {
    if (!_isValid()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final id = note.id;
    final title = titleController.text;
    final content = contentController.text;

    try {
      _showLoading();
      await _repository.updateNote(id, title, content);
      Get.back();
    } catch (e) {
      
      CustomSnackBar.showError(
          context: Get.context,
          title:'Add Note Failed',
          message: e.toString(),
        );
    
    }finally{
      _hideLoading();
    }
  
  }


  _showLoading() {
    isLoading = true;
    update();
  } 
  _hideLoading() {
    isLoading = false;
    update();
  } 

}