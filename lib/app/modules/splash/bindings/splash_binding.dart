import 'package:e_commerce_app/app/modules/account/controllers/account_controller.dart';
import 'package:e_commerce_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:e_commerce_app/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    // Get.put(HomeController());
    // Get.put(CartController());
    // Get.put(CheckoutController());
    // Get.put(AccountController());
    // Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<CheckoutController>(() => CheckoutController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
