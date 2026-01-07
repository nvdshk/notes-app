import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/data/models/user_model.dart';

class Database {
   final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final String userCollection = "users";
  final String noteCollection = "notes";

  Future<void> createNewUser(UserModel user) async {
       final now = Timestamp.now();

      await _firestore
          .collection(userCollection)
          .doc(user.id)
          .set({
            'userId': user.id, 
            'name': user.name,
            'email': user.email,
            'created_at': now,
          });
    
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  String? get uid => _auth.currentUser?.uid;

  Stream<List<NoteModel>> getNotesStream() {
    if (uid == null) {
      return const Stream.empty(); 
      
    }

    return _firestore
        .collection(noteCollection)
        .where('userId', isEqualTo: uid)
        .orderBy('updated_at', descending: true)
        .snapshots()
        .map((query) => query.docs.map((doc) => NoteModel.fromFirestore(doc)).toList());
  }

  Future<void> addNote(String title, String content) async {
    if (uid == null) throw Exception("User not logged in");

    final docRef = _firestore.collection(noteCollection).doc();
    
    final now = Timestamp.now();
    await docRef.set({
    'id': docRef.id, 
    'userId': uid,
    'title': title,
    'content': content,
    'created_at':now,
    'updated_at': now,
  });
  }

  Future<void> updateNote({
  required String id,
  required String title,
  required String content,
}) async {
      final now = Timestamp.now();

   await _firestore.collection(noteCollection).doc(id).update({
    'title': title,
    'content': content,
    'updated_at':now,
  });
  }

  Future<void> deleteNote(String id) async {
    await _firestore.collection(noteCollection).doc(id).delete();
  }
}