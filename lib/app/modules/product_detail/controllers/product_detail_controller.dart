import 'package:e_commerce_app/app/data/models/product/all_products_model.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  // late Product product; // ✅ هنا نخزن المنتج المحدد
    late AllProductsModel product; // ✅ نفس نوع البيانات اللي من API
    var isFavorite = false.obs; // ⭐ حالة النجمة

  @override
  void onInit() {
    super.onInit();
     product = Get.arguments as AllProductsModel; // ✅ استلام المنتج
    // product = Get.arguments as Product; // ✅ استقبال المنتج
  }
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value; // تبديل الحالة عند الضغط
  }
}
