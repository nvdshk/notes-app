import 'package:flutter/material.dart';
import 'package:notes_app/core/constants/app_size_constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final bool? readOnly;
  final bool? enabled;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function? onTap;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.controller,
    this.keyboardType,
    this.readOnly,
    this.enabled,
    this.maxLines = 1,
    this.suffixIcon,
    this.obscureText = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: readOnly ?? false,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: AppSize.textSize14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.borderRadius8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppSize.borderRadius8),
        ),
      ),
    );
  }
}
