import 'package:code_swifter_demo_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String text;
  final String? initialText;
  final Function(String value)? onChange;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? textInputType;
  final Function()? prefixIconTap;
  final bool? obsecureText;
  final bool? readOnly;
  final Color? borderColor;
  final double? borderSideWidth;
  final int? maxLines;
  final double? contentPadding;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction? textInputAction;
  final bool? autofocus;
  final Color? filledColor;

  const CustomTextfield({
    super.key,
    this.controller,
    this.validation,
    this.textInputType,
    this.prefixIconTap,
    required this.text,
    this.obsecureText,
    this.prefix,
    this.onChange,
    this.suffix,
    this.initialText,
    this.borderColor,
    this.borderSideWidth,
    this.maxLines,
    this.contentPadding,
    this.inputFormatter,
    this.textInputAction,
    this.readOnly,
    this.autofocus,
    this.filledColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.buttonColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextFormField(
          autofocus: autofocus ?? false,
          inputFormatters: inputFormatter,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          readOnly: readOnly ?? false,
          validator: validation,
          controller: controller,
          onChanged: onChange,
          obscureText: obsecureText ?? false,
          initialValue: initialText,
          maxLines: maxLines ?? 1,
          cursorColor: AppColors.secondaryColor,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(
              fontSize: 16,
              color: AppColors.secondaryColor.withOpacity(0.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: contentPadding ?? 17,
              horizontal: 20,
            ),
            prefixIcon: prefix,
            suffixIcon: suffix,
            fillColor: filledColor?? AppColors.primaryColor,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.primaryColor,
                // color: borderColor ?? AppColors.buttonColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                // color: borderColor ?? AppColors.buttonColor,
                color: borderColor ?? AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: borderColor ?? AppColors.primaryColor,
                  // color: borderColor ?? AppColors.buttonColor,
                  width: borderSideWidth ?? 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
