import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final getStorage = GetStorage();
  void signUp() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    getStorage.write('id', 1);
    Get.toNamed(Routes.HOME);
    print("Name: $name, Email: $email, Password: $password");
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
