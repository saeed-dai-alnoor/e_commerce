import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final FocusNode emailFocus = FocusNode();
    final FocusNode passwordFocus = FocusNode();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Welcome,',
                            style: GoogleFonts.inter(fontSize: 30),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Sign in to Continue',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.SIGN_UP),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.inter(
                            color: Color(0xFF00C569),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.emailController,
                    focusNode: emailFocus,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Email'),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.passwordController,
                    focusNode: passwordFocus,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    obscureText: !controller
                        .isPasswordVisible
                        .value, // Toggle visibility
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          if (controller.loginFormKey.currentState
                                  ?.validate() ??
                              false) {
                            controller.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: Color(0xFF00C569),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                "SIGN IN",
                                style: const TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(child: Text('- OR -')),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // controller.loginWithFacebook();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.facebook, color: Colors.blue),
                        SizedBox(width: 20),
                        Text(
                          'Sign In with Facebook',
                          style: GoogleFonts.inter(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // controller.loginWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Sign In with Google',
                          style: GoogleFonts.inter(fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
