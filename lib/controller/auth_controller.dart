import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_swifter_demo_app/constants/app_constants.dart';
import 'package:code_swifter_demo_app/constants/app_routes.dart';
import 'package:code_swifter_demo_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class AuthController extends GetxController {
  static final instance = Get.find<AuthController>();
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxInt selectedAge = 10.obs;

  updateAge(int age) {
    selectedAge.value = age;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage.FirebaseStorage storage =
      firebaseStorage.FirebaseStorage.instance;
  UserCredential? userCredential;

  UserModel? userModel;

  Future<void> signup(String name, String password) async {
    isLoading.value = true;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: password,
      );
      if (userCredential != null) {
        User? user = userCredential!.user;

        if (user != null) {
          await firebaseFirestore.collection('users').doc(user.uid).set({
            'userid': user.uid,
            'email': emailController.text,
            'password': password,
            'name': name,
            'image': "",
            'age': null,
            'phone': null,
            'countryCode': null,
          });
        }
        AppConstants.showSnackBar('Success', 'Register Successfully');
        emailController.clear();
        Get.offAndToNamed(AppRoutes.welcomeScreen);
        isLoading.value = false;
      } else {
        AppConstants.showSnackBar('Error', 'Something went wrong');
        isLoading.value = false;
      }
    } on FirebaseAuthException catch (e) {
      AppConstants.showSnackBar('Error', e.message.toString());
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential != null) {
        AppConstants.showSnackBar('Success', 'Login Successfully');
        Get.offAllNamed(AppRoutes.profileScreen);
        isLoading.value = false;
      } else {
        AppConstants.showSnackBar('Error', 'Something went wrong');
        isLoading.value = false;
      }
    } on FirebaseAuthException catch (e) {
      AppConstants.showSnackBar('Error', e.message.toString());
      isLoading.value = false;
    }
  }

  RxBool emailExists = false.obs;

  Future<void> checkUserExist() async {
    isLoading.value = true;
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: emailController.text)
          .get();
      emailExists.value = true;
      userModel = UserModel.fromJson(userData.docs.first.data());
      isLoading.value = false;
    } catch (e) {
      print("Exception ${e.toString()}");
      emailExists.value = false;
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    isLoading.value = true;

    try {
      print("user id ${userModel!.userid}");
      String imageUrl = await uploadImageOnFirebase();
      await firebaseFirestore
          .collection('users')
          .doc(userModel!.userid)
          .update({
        'name': userModel!.name,
        'age': userModel!.age,
        'phone': userModel!.phone,
        'countryCode': userModel!.countryCode ?? '+92',
        'image': imageUrl
      });

      AppConstants.showSnackBar("Success", "Profile Updated");

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      AppConstants.showSnackBar('Error', e.toString());
    }
  }

  Future<String> uploadImageOnFirebase() async {
    try {
      String fileName = userModel!.name.toString();

      firebaseStorage.Reference ref = storage.ref('/images' + '$fileName');
      firebaseStorage.UploadTask uploadTask =
          ref.putFile(image.value!.absolute);

      await Future.value(uploadTask);
      var url = ref.getDownloadURL();

      AppConstants.showSnackBar("Success", "Image Uploaded");
      return url;
    } catch (e) {
      AppConstants.showSnackBar('Error', e.toString());
      return '';
    }
  }

  var image = Rx<File?>(null);

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      AppConstants.showSnackBar('Error', 'Something went wrong');
    }
  }
}
