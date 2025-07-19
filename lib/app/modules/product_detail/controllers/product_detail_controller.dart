import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var selectedOption = 0.obs;

  void selectOption(int index) {
    selectedOption.value = index;
  }



}
