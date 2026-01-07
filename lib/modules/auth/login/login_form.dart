import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/constants/app_size_constants.dart';
import 'package:notes_app/core/constants/app_string_constants.dart';
import 'package:notes_app/core/widgets/custom_text_form_field.dart';
import 'package:notes_app/modules/auth/login/login_controller.dart';
import 'package:notes_app/routes/app_routes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.generalPadding16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.login,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSize.textSize38,
              fontWeight: FontWeight.w700,
            ),
          ),
        
          SizedBox(height: AppSize.space20),
          _EmailTextFormField(),
          SizedBox(height: AppSize.space12),
          _PasswordTextFormField(),
          SizedBox(height: AppSize.space30),
          _LoginButton(),
          _SignUpTextButton()
        ],
      ),
    );
  }
}

class _EmailTextFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => CustomTextFormField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        hintText: AppString.enterEmail,
      ),
    );
  }
}

class _PasswordTextFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => CustomTextFormField(
        controller: controller.passwordController,
        keyboardType: TextInputType.text,
        hintText: AppString.enterPassword,
        suffixIcon: IconButton(
          onPressed: () {
            controller.onShowPassword();
          },
          icon: Icon(
            controller.passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        obscureText: !controller.passwordVisible,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      id: 'login',
      builder: (controller) => controller.isLoading ? Center(
        child: CircularProgressIndicator()
        ) : ElevatedButton(
        onPressed: controller.onLogin,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.buttonCircularRadius),
          ),
          fixedSize: Size.fromWidth(
            MediaQuery.of(context).size.width,
          ),
        ),
        child: Text(AppString.login),
      ),
    );
  }
}


class _SignUpTextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          await Get.toNamed(AppRoutes.signup);
          
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              AppString.signUp,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}

