
import 'package:code_swifter_demo_app/constants/app_colors.dart';
import 'package:code_swifter_demo_app/utils/custom_text.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final double? height, width, borderRadius, textSize, borderWidth;
  final String? title;
  final Color? bgColor;
  final void Function()? onTap;
  final Color? borderColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? isMultipleWidget;
  final Widget? widget;
  const CustomBtn({
    super.key,
    this.height,
    this.width,
    required this.onTap,
    this.title,
    this.bgColor,
    this.borderColor,
    this.borderRadius,
    this.textColor,
    this.textSize,
    this.borderWidth,
    this.fontWeight,
    this.isMultipleWidget = false,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height ?? 55,
      // minWidth: width,
      minWidth: width ?? double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: bgColor ?? AppColors.buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        side: BorderSide(
          width: borderWidth ?? 2,
          color: borderColor ?? AppColors.buttonColor,
        ),
      ),
      child: isMultipleWidget == false
          ? Center(
              child: FittedBox(
                child: CustomText(
                  title: title!,
                  color: textColor ?? AppColors.primaryColor,
                  fontWeight: fontWeight ?? FontWeight.bold,
                  size: textSize ?? 18,
                ),
              ),
            )
          : widget,
    );
  }
}
