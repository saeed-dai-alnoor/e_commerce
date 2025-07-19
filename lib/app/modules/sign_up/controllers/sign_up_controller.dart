import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    // TODO: Add sign-up logic here
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
