import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var selectedOption = DeliveryOption.standard.obs;
  final stepIndex = 0.obs;

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
