import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var selectedOption = DeliveryOption.standard.obs;
  var address = ''.obs;
  final stepIndex = 0.obs;
  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

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
