import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var selectedOption = DeliveryOption.standard.obs;
  var address = ''.obs;
  final stepIndex = 0.obs;

}

enum DeliveryOption { standard, nextDay, nominated }
