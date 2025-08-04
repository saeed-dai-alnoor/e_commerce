import 'dart:async';

import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final getStorge = GetStorage();
  Future<void> initApp() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final storage = getStorge.read('id');

    switch (storage) {
      case 1:
        Get.offNamed(Routes.HOME);
        break;
      // case 2:
      //   Get.offNamed(Routes.HOME);
      //   break;
      // case 3:
      //   Get.offNamed(Routes.USER_KIND);
      //   break;
      // case 4:
      //   Get.offNamed(Routes.USER_KIND);
      //   break;
      // case 5:
      //   Get.offNamed(Routes.USER_KIND);
      //   break;
      // case 6:
      //   Get.offNamed(Routes.STUDENT_HOME);
      //   break;
      // case 7:
      //   Get.offNamed(Routes.TEACHER_HOME);
      //   break;
      // case 8:
      //   Get.offNamed(Routes.MANAGEMENT_HOME);
      //   break;
      // case 9:
      //   Get.offNamed(Routes.USER_KIND);
      //   break;

      default:
        Future.delayed(
          const Duration(milliseconds: 900),
          () => Get.toNamed(Routes.LOGIN),
        );
    }
  }

  @override
  void onReady() {
    super.onReady();
    initApp();
  }
}
