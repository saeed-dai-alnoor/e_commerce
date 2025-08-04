import 'package:get/get.dart';

import '../controllers/category_result_controller.dart';

class CategoryResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryResultController>(
      () => CategoryResultController(),
    );
  }
}
