import 'package:e_commerce_app/app/controllers/internet_controller.dart';
import 'package:e_commerce_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce_app/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(CartController());
  Get.put(SplashController());
  final internetController = Get.put(InternetController());
  runApp(
    GetMaterialApp(
      title: "E Commerce App",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      builder: (context, child) {
        internetController.startMonitoring(context); // تشغيل المراقبة
        return child!;
      },
    ),
  );
}
