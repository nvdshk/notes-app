import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/constants/app_size_constants.dart';
import 'package:notes_app/core/constants/app_string_constants.dart';
import 'package:notes_app/core/widgets/custom_text_form_field.dart';
import 'package:notes_app/modules/notes/add/add_note_controller.dart';

class AddNoteForm extends StatelessWidget {
  const AddNoteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.generalPadding16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
  
        
          SizedBox(height: AppSize.space20),
          _TitleTextFormField(),
          SizedBox(height: AppSize.space12),
          _ContentTextFormField(),
          SizedBox(height: AppSize.space30,),
          _SubmitButton()
         
        ],
      ),
    );
  }
}

class _TitleTextFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNoteController>(
      builder: (controller) => CustomTextFormField(
        controller: controller.titleController,
        keyboardType: TextInputType.text,
        hintText: AppString.enterTitle,
      ),
    );
  }
}


class _ContentTextFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNoteController>(
      builder: (controller) => CustomTextFormField(
        controller: controller.contentController,
        keyboardType: TextInputType.text,
        hintText: AppString.enterContent,
        maxLines: 5,
      ),
    );
  }
}


class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNoteController>(
      builder: (controller) => controller.isLoading ? Center(
        child: CircularProgressIndicator(),
        ) :  ElevatedButton(
        onPressed: controller.addNote,
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
        child: Text(AppString.submit),
      ),
    );
  }
}




