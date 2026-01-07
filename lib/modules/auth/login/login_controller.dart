import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/constants/app_string_constants.dart';
import 'package:notes_app/core/widgets/custom_snackbar.dart';
import 'package:notes_app/data/repositories/auth_repository.dart';
import 'package:notes_app/routes/app_routes.dart';

class LoginController extends GetxController {

  final AuthRepository _repository = AuthRepository();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool passwordVisible = false;


  bool isLoading = false;



  @override
  void onInit() {
    
    emailController = TextEditingController();
   passwordController = TextEditingController();   
    super.onInit();
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }


  clear(){
    emailController.clear();
    passwordController.clear();
  }

 bool _isValid() {
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


 Future<void> onLogin() async {
    if (!_isValid()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final email = emailController.text;
    final password = passwordController.text;

    try {
      _showLoading();
      await _repository.login(email, password);
      Get.offAllNamed(AppRoutes.notes);


     clear();
    } catch (e) {
      
      CustomSnackBar.showError(
          context: Get.context,
          title:'Login Failed',
          message: e.toString(),
        );
    
    } finally{
      _hideLoading();
      
     
    }
  
  }


  _showLoading() {
    isLoading = true;
    update(['login']);
  } 
  _hideLoading() {
    isLoading = false;
    update(['login']);
  } 



Future<void> logout() async {
    try {
      await _repository.logout();
      Get.offAndToNamed(AppRoutes.login);
  
    } catch (e) {

        CustomSnackBar.showError(
          context: Get.context,
          title:'Logout Failed',
          message: e.toString(),
        );
    }
  }

}