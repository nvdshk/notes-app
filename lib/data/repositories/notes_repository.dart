import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/data/services/database.dart';

class NotesRepository {


   final Database _database = Database();
   
   Stream<List<NoteModel>> getNotesStream() {
    return _database.getNotesStream();
  }
  
  Future<void> addNote(String title, String content) async {
    await _database.addNote( title, content);
  }

  Future<void> updateNote(String id, String title, String content) async {
    await _database.updateNote(id: id, title: title, content: content,
    );
  }

  Future<void> deleteNote(String id) async {
    await _database.deleteNote(id);
  }
}
