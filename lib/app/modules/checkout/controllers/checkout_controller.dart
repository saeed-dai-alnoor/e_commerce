import 'package:e_commerce_app/app/modules/checkout/views/payment_view.dart';
import 'package:e_commerce_app/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/order/order_creator_repository.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  var selectedOption = DeliveryOption.standard.obs;
  final stepIndex = 0.obs;
  final orderRepo = OrderCreatorRepository();

  var isFormValid = false.obs;
  final formKeyAddress = GlobalKey<FormState>();

  // البيانات
  var street1 = ''.obs;
  var street2 = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var country = ''.obs;
  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  // 🔹 أسعار طرق التوصيل
  final Map<DeliveryOption, double> deliveryPrices = {
    DeliveryOption.standard: 5.0,
    DeliveryOption.nextDay: 15.0,
    DeliveryOption.nominated: 10.0,
  };

  // 🔹 نسبة الضريبة (مثلاً 15%)
  final double taxRate = 0.15;

  // 🔹 حساب سعر التوصيل الحالي
  double get deliveryPrice => deliveryPrices[selectedOption.value] ?? 0.0;

  // 🔹 حساب الضريبة
  double calculateTax(double subtotal) {
    return subtotal * taxRate;
  }

  // 🔹 حساب الإجمالي النهائي
  double calculateTotal(double cartTotal) {
    final tax = calculateTax(cartTotal);
    return cartTotal + deliveryPrice + tax;
  }

  void validateForm() {
    if (formKeyAddress.currentState != null) {
      isFormValid.value = formKeyAddress.currentState!.validate();
    }
  }

  Future<void> createOrderAndPay() async {
    try {
      final cartController = Get.find<CartController>();
      final splashController = Get.find<SplashController>();
      // 🟢 جهز items من الكارت
      final items = cartController.cartItems.map((product) {
        return {"productId": product.id, "quantity": product.quantity};
      }).toList();

      // 🟢 جهز عنوان الشحن
      final shippingAddress = {
        "street1": street1.value,
        "street2": street2.value,
        "city": city.value,
        "state": state.value,
        "country": country.value,
      };

      // 🟢 هات التوكن (افترض إنك مخزنه في GetStorage مثلاً)
      final token = splashController.token;

      // 🟢 اعمل الأوردر
      final orderData = await orderRepo.createOrder(
        items: items,
        shippingAddress: shippingAddress,
        token: token,
      );

      // 🟢 لو رجع لينك الدفع → افتح صفحة الدفع
      final paymentUrl = orderData["paymentUrl"];
      final orderId = orderData["orderId"];

      if (paymentUrl != null) {
        // افتح صفحة WebView مستقلة
        Get.to(
          () => PaymentView(
            paymentUrl: paymentUrl,
            orderId: orderId,
            token: token,
          ),
        );
      } else {
        Get.snackbar("Order", "Order Created Successfully!");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    street1Controller.dispose();
    street2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
  }
}

enum DeliveryOption { standard, nextDay, nominated }
