import 'package:code_swifter_demo_app/constants/app_colors.dart';
import 'package:code_swifter_demo_app/constants/app_constants.dart';
import 'package:code_swifter_demo_app/controller/auth_controller.dart';
import 'package:code_swifter_demo_app/utils/base_screen.dart';
import 'package:code_swifter_demo_app/utils/custom_button.dart';
import 'package:code_swifter_demo_app/utils/custom_text.dart';
import 'package:code_swifter_demo_app/utils/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final authController = AuthController.instance;
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
                  title: 'Login',
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
                            ListTile(
                              leading: authController.userModel!.image!.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          authController.userModel!.image!),
                                    )
                                  : const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                              title: CustomText(
                                title: '${authController.userModel!.name}',
                                size: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: CustomText(
                                title: '${authController.userModel!.email}',
                                size: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Obx(() {
                              return CustomTextfield(
                                controller: authController.passwordController,
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
                            Obx(() {
                              return authController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomBtn(
                                      onTap: () {
                                        if (authController
                                            .passwordController.text.isEmpty) {
                                          AppConstants.showSnackBar('Error',
                                              'Fields must be required');
                                        } else {
                                          authController.login();
                                        }
                                      },
                                      title: 'Continue',
                                    );
                            }),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            InkWell(
                              onTap: () {
                                AppConstants.showSnackBar(
                                    'Under-Construction', 'Work on progress');
                              },
                              child: const CustomText(
                                title: 'Forgot your password?',
                                size: 18,
                                color: AppColors.buttonColor,
                              ),
                            ),
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
