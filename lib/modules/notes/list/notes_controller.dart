
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/widgets/custom_snackbar.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/data/repositories/notes_repository.dart';
import 'package:notes_app/routes/app_routes.dart';

class NotesController extends GetxController {
  final NotesRepository _repository = NotesRepository();


  final FirebaseAuth _auth = FirebaseAuth.instance;

   List<NoteModel> notes = [];

   String search = '';



  bool isLoading = false;


    @override
  void onReady() {
    super.onReady();
        _loadNotes();
  }

void _loadNotes() {
    if (_auth.currentUser == null) {
      
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    _showLoading();
    _repository.getNotesStream().listen((event) {
      notes = event;
    _hideLoading();
      update();
    });
  }


void setSearch(String value) {
    search = value;
    update();
  }

  List<NoteModel> get filteredNotes {
    if (search.isEmpty) return notes;
    return notes
        .where((note) => note.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  


  Future<void> deleteNote(String id) async {
    try {
      await _repository.deleteNote(id);

        CustomSnackBar.showSuccess(
          context: Get.context,
          title:'Success',
          message: 'Note deleted',
        );
    } catch (e) {
        CustomSnackBar.showError(
          context: Get.context,
          title:'Add Note Failed',
          message: e.toString(),
        );
    }
  }


  
   _showLoading() {
    isLoading = true;
   
  } 
  _hideLoading() {
    isLoading = false;
   
  } 
 
}