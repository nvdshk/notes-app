import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/constants/app_string_constants.dart';
import 'package:notes_app/core/widgets/custom_snackbar.dart';
import 'package:notes_app/data/repositories/auth_repository.dart';
import 'package:notes_app/routes/app_routes.dart';

class SignUpController extends GetxController {

  final AuthRepository _repository =  AuthRepository();

  Rxn<User> user = Rxn<User>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;

  bool isLoading = false;


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }


 bool _isValid() {
   if (userNameController.text.trim().isEmpty) {
      CustomSnackBar.showError(
        context: Get.context,
        title: AppString.error,
        message: AppString.enterName,
      );
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      CustomSnackBar.showError(
        context: Get.context,
        title: AppString.error,
        message: AppString.enterEmail,
      );
      return false;
    }
    if (!emailController.text.trim().isEmail) {
      CustomSnackBar.showError(
        context: Get.context,
        title: AppString.error,
        message: AppString.enterValidEmail,
      );
      return false;
    }

    if (passwordController.text.trim().isEmpty) {
      CustomSnackBar.showError(
        context: Get.context,
        title: AppString.error,
        message: AppString.enterPassword,
      );
      return false;
    }
    if (passwordController.text.trim().length < 8) {
      CustomSnackBar.showError(
        context: Get.context,
        title: AppString.error,
        message: AppString.passwordMustBe8CharactersLong,
      );

      return false;
    }

    return true;
  }

   void onShowPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

   _showLoading() {
    isLoading = true;
    update(['signup']);
  } 
  _hideLoading() {
    isLoading = false;
    update(['signup']);
  } 


 Future<void> onSignUp() async {
    if (!_isValid()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final name = userNameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    try {
      _showLoading();
      await _repository.signUp(name, email, password);
      Get.offAllNamed(AppRoutes.notes);
    } catch (e) {
      
      CustomSnackBar.showError(
          context: Get.context,
          title:'SingUp Failed',
          message: e.toString(),
        );
    
    }finally{
      _hideLoading();
      
    }
  
  }


  clear(){
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

}