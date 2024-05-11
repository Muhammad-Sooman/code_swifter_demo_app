import 'package:code_swifter_demo_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final bool? resizeToAvoidBottomInset;
  const BaseScreen({required this.child, this.resizeToAvoidBottomInset, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/lady.png'),
              fit: BoxFit.cover
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
