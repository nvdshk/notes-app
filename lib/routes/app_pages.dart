import 'package:get/get.dart';
import 'package:notes_app/modules/auth/login/login_controller.dart';
import 'package:notes_app/modules/auth/login/login_view.dart';
import 'package:notes_app/modules/auth/signup/signup_controller.dart';
import 'package:notes_app/modules/auth/signup/signup_view.dart';
import 'package:notes_app/modules/notes/add/add_note_controller.dart';
import 'package:notes_app/modules/notes/add/add_note_view.dart';
import 'package:notes_app/modules/notes/edit/edit_note_controller.dart';
import 'package:notes_app/modules/notes/edit/edit_note_view.dart';
import 'package:notes_app/modules/notes/list/notes_controller.dart';
import 'package:notes_app/modules/notes/list/notes_view.dart';
import 'package:notes_app/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
       binding: BindingsBuilder(() {
        Get.put(LoginController(), permanent: true,);
        
      }),
      ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupView(),
      binding: BindingsBuilder(() {
        Get.put(SignUpController());
      }),
      ),
    GetPage(
      name: AppRoutes.notes,
      page: () => NotesView(),
      binding: BindingsBuilder(() {
        Get.put(NotesController());
      }),
      ),
    GetPage(
      name: AppRoutes.addNote,
      page: () => AddNoteView(),
       binding: BindingsBuilder(() {
        Get.put(AddNoteController());
      }),
      ),
    GetPage(
      name: AppRoutes.editNote, 
      page: () => EditNoteView(),
      binding: BindingsBuilder(() {
        Get.put(EditNoteController());
      }),
    ),
  ];
}