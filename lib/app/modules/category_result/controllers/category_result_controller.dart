import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:e_commerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class CategoryResultController extends GetxController {
  final filteredProducts = <Product>[].obs;
  late String category;
  // استلام التصنيف من الصفحة السابقة
  // final Product selectedProduct = Get.arguments;

  // احصل على كل المنتجات من HomeController
  final allProducts = Get.find<HomeController>().allProducts;

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments;
    // فلترة المنتجات التي تنتمي لنفس التصنيف
    final homeController = Get.find<HomeController>();
    filteredProducts.value = homeController.allProducts
        .where((p) => p.category == category)
        .toList();
  }
}
