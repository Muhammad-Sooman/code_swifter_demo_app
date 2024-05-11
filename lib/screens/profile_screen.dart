import 'package:code_swifter_demo_app/constants/app_colors.dart';
import 'package:code_swifter_demo_app/controller/auth_controller.dart';
import 'package:code_swifter_demo_app/utils/base_screen.dart';
import 'package:code_swifter_demo_app/utils/custom_button.dart';
import 'package:code_swifter_demo_app/utils/custom_text.dart';
import 'package:code_swifter_demo_app/utils/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final authController = AuthController.instance;
    // final width = MediaQuery.of(context).size.width;
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
                  height: height * 0.05,
                ),
                const CustomText(
                  title: 'Profile',
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
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                      height: Get.height * 0.15,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          )),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: const CustomText(
                                                title:
                                                    'Pick Image From Gallery'),
                                            onTap: () {
                                              authController.pickImage(
                                                  ImageSource.gallery);
                                            },
                                          ),
                                          ListTile(
                                            title: const CustomText(
                                                title:
                                                    'Pick Image From Camera'),
                                            onTap: () {
                                              authController.pickImage(
                                                  ImageSource.camera);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Obx(() {
                                  return authController.userModel != null &&
                                          authController.userModel!.image !=
                                              "" &&
                                          authController.image.value == null
                                      ? CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                              authController.userModel!.image!),
                                        )
                                      : authController.image.value != null
                                          ? CircleAvatar(
                                              radius: 60,
                                              backgroundImage: FileImage(
                                                  authController
                                                      .image.value!.absolute),
                                            )
                                          : const CircleAvatar(
                                              radius: 60,
                                              child: Icon(
                                                Icons.person,
                                                size: 50,
                                              ),
                                            );
                                  //               ),
                                }),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomTextfield(
                              // controller: nameController,
                              text: '${authController.userModel!.email}',
                              readOnly: true,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomTextfield(
                              initialText: authController.userModel!.name ?? '',
                              onChange: (value) {
                                authController.userModel!.name = value;
                              },
                              text: 'Name',
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomTextfield(
                              // controller: phoneNoController,
                              prefix: CountryCodePicker(
                                boxDecoration: const BoxDecoration(
                                  color: AppColors.secondaryColor,
                                ),
                                dialogTextStyle: const TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                                searchDecoration: const InputDecoration(
                                    prefixIconColor: AppColors.primaryColor),
                                textStyle: const TextStyle(
                                    color: AppColors.secondaryColor),
                                favorite: const ['+92', 'PK'],
                                initialSelection:
                                    authController.userModel?.countryCode ??
                                        '+92',
                                onChanged: (CountryCode countryCode) {
                                  authController.userModel?.countryCode =
                                      countryCode.dialCode.toString();
                                },
                              ),
                              textInputType: TextInputType.phone,
                              text: 'Phone Number',
                              initialText:
                                  authController.userModel?.phone ?? '',
                              onChange: (value) {
                                authController.userModel?.phone = value;
                              },
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: AppColors.buttonColor),
                              ),
                              child: Obx(() {
                                return DropdownButton<int>(
                                  isExpanded: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  value: authController.selectedAge.value,
                                  // value: authController.userModel!.age ?? authController.selectedAge.value,
                                  onChanged: (int? age) {
                                    authController.userModel!.age = age;
                                    authController.updateAge(age!);
                                  },
                                  items: List.generate(
                                          91, (index) => index + 10)
                                      .map<DropdownMenuItem<int>>((int val) {
                                    return DropdownMenuItem<int>(
                                      value: val,
                                      child: Text('$val'),
                                    );
                                  }).toList(),
                                );
                              }),
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
                                        await authController.updateProfile();
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
