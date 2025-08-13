import 'dart:async';

import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  void _checkAuth() async {
    final storge = GetStorage();
    final token = storge.read('token');
    await Future.delayed(Duration(milliseconds: 500)); // وقت الانتظار
    if (token != null) {
      Get.offAllNamed(Routes.HOME); // المستخدم مسجل
    } else {
      Get.offAllNamed(Routes.LOGIN); // غير مسجل
    }
  }

  @override
  void onReady() {
    super.onReady();
    print("🟢 SplashController onReady"); // تأكد من ظهورها
    _checkAuth();
  }

  @override
  void onInit() {
    super.onInit();
    // GetStorage().erase();
  }
}
