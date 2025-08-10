import 'package:get/get.dart';

import '../controllers/product_dashboard_controller.dart';

class ProductDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDashboardController>(
      () => ProductDashboardController(),
    );
  }
}
