import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
    var email = ''.obs;
  var password = ''.obs;
    final getStorage = GetStorage();


  void login() {
getStorage.write('id', 1);
    Get.toNamed(Routes.HOME);
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
