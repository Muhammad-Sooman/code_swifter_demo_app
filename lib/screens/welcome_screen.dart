import 'package:code_swifter_demo_app/constants/app_colors.dart';
import 'package:code_swifter_demo_app/constants/app_constants.dart';
import 'package:code_swifter_demo_app/constants/app_routes.dart';
import 'package:code_swifter_demo_app/controller/auth_controller.dart';
import 'package:code_swifter_demo_app/utils/base_screen.dart';
import 'package:code_swifter_demo_app/utils/custom_button.dart';
import 'package:code_swifter_demo_app/utils/custom_text.dart';
import 'package:code_swifter_demo_app/utils/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.height;
    final authController = Get.put(AuthController());
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
                  title: 'Hi!',
                  size: 32,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: height * 0.1,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomTextfield(
                              controller: authController.emailController,
                              text: 'Enter Email',
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
                                      onTap: () async {
                                        if (authController
                                            .emailController.text.isEmpty) {
                                          AppConstants.showSnackBar('Error',
                                              'Fields must be required');
                                        } else {
                                          await authController.checkUserExist();
                                          if (authController
                                              .emailExists.value == true) {
                                            Get.toNamed(AppRoutes.loginScreen);
                                          } else {
                                            AppConstants.showSnackBar('Request',
                                                'Email does not exist. Kindly register your account');
                                            Get.toNamed(AppRoutes.signupScreen);
                                          }
                                        }
                                      },
                                      title: 'Continue',
                                    );
                            }),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                title: 'or',
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomBtn(
                              bgColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryColor,
                              onTap: () {
                                AppConstants.showSnackBar(
                                    'Under-Construction', 'Work on progress');
                              },
                              isMultipleWidget: true,
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.facebook,
                                    color: AppColors.blue900Color,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const CustomText(
                                    title: 'Continue with Facebook',
                                    size: 16,
                                    color: AppColors.secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomBtn(
                              bgColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryColor,
                              onTap: () {
                                AppConstants.showSnackBar(
                                    'Under-Construction', 'Work on progress');
                              },
                              isMultipleWidget: true,
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.g_mobiledata,
                                    color: AppColors.blue900Color,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const CustomText(
                                    title: 'Continue with Google',
                                    size: 16,
                                    color: AppColors.secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomBtn(
                              bgColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryColor,
                              onTap: () {
                                AppConstants.showSnackBar(
                                    'Under-Construction', 'Work on progress');
                              },
                              isMultipleWidget: true,
                              widget: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.apple,
                                    color: AppColors.secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomText(
                                    title: 'Continue with Apple',
                                    size: 16,
                                    color: AppColors.secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: [
                                const CustomText(
                                  title: 'Don\'t have an account? ',
                                  size: 18,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.signupScreen);
                                  },
                                  child: const CustomText(
                                    title: 'Sign up',
                                    color: AppColors.buttonColor,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const CustomText(
                                title: 'Forgot your password?',
                                size: 18,
                                color: AppColors.buttonColor,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
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
