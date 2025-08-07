import 'package:e_commerce_app/app/data/models/user_model.dart';
import 'package:e_commerce_app/app/data/repositories/signup_repository.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  // For password visibility toggle
  final isPasswordVisible = false.obs;

  final repository = SignupRepository();
  final getStorage = GetStorage();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signup() async {
    // Check if form is valid before proceeding
    if (!signUpFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    final user = UserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      final response = await repository.signupUser(user);
      Get.snackbar("Success", "User signup successfully!");
      print(response.data);
      Get.toNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
