import 'package:get/get.dart';

class LoginController extends GetxController {
    var email = ''.obs;
  var password = ''.obs;

  void login() {
    // هنا منطق تسجيل الدخول
    print('Email: $email, Password: $password');
  }

  void loginWithFacebook() {
    // تسجيل الدخول باستخدام فيسبوك
  }

  void loginWithGoogle() {
    // تسجيل الدخول باستخدام جوجل
  }


}
