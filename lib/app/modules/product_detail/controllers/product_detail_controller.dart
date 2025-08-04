import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  late Product product; // ✅ هنا نخزن المنتج المحدد
    var isFavorite = false.obs; // ⭐ حالة النجمة

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Product; // ✅ استقبال المنتج
  }
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value; // تبديل الحالة عند الضغط
  }
}
