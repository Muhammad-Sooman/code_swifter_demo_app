import 'package:code_swifter_demo_app/constants/app_colors.dart';
import 'package:code_swifter_demo_app/constants/app_constants.dart';
import 'package:code_swifter_demo_app/controller/auth_controller.dart';
import 'package:code_swifter_demo_app/utils/base_screen.dart';
import 'package:code_swifter_demo_app/utils/custom_button.dart';
import 'package:code_swifter_demo_app/utils/custom_text.dart';
import 'package:code_swifter_demo_app/utils/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final authController = AuthController.instance;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    // final width = MediaQuery.of(context).size.height;
    return BaseScreen(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.15,
                ),
                const CustomText(
                  title: 'Sign up',
                  size: 32,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.black45,
                          Colors.black87,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const CustomText(
                              title: 'Looks like you don\'t have account ',
                              size: 16,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const CustomText(
                              title: 'Let\'s create new account for',
                              size: 16,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            CustomText(
                              title: authController.userModel == null ? authController.emailController.text : '${authController.userModel!.email}',
                              size: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomTextfield(
                              controller: nameController,
                              text: 'Name',
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Obx(() {
                              return CustomTextfield(
                                controller: passwordController,
                                text: 'Password',
                                obsecureText:
                                    authController.isPasswordVisible.value,
                                suffix: InkWell(
                                    onTap: () {
                                      authController.togglePassword();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CustomText(
                                        title: authController
                                                .isPasswordVisible.value
                                            ? 'View'
                                            : 'Hide',
                                        color: AppColors.secondaryColor,
                                      ),
                                    )),
                              );
                            }),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            RichText(
                              text: const TextSpan(
                                  text:
                                      'By Selecting Agree and continue below,\nI agree to ',
                                  style: TextStyle(fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: 'Term of Services ',
                                      style: TextStyle(
                                        color: AppColors.buttonColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'and ',
                                      style: TextStyle(
                                        color: AppColors.buttonColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Privacy policy',
                                      style: TextStyle(
                                        color: AppColors.buttonColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Obx(() {
                              return authController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomBtn(
                                      onTap: () {
                                        if (nameController.text.isEmpty &&
                                            passwordController.text.isEmpty) {
                                          AppConstants.showSnackBar('Error',
                                              'Fields must be required');
                                        } else {
                                          authController.signup(
                                              nameController.text,
                                              passwordController.text);
                                        }
                                      },
                                      title: 'Continue',
                                    );
                            }),
                            SizedBox(
                              height: height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
