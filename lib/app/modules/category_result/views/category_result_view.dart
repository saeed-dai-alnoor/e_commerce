import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:e_commerce_app/app/widgets/my_custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_result_controller.dart';

class CategoryResultView extends GetView<CategoryResultController> {
  const CategoryResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        automaticallyImplyLeading: false,
        title: Text(controller.category), // ✅ العنوان هو اسم المنتج
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 2,
            childAspectRatio: 0.40,
          ),
          itemCount: controller.filteredProducts.length - 1,
          itemBuilder: (context, index) {
            final product = controller.filteredProducts[index + 1];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.PRODUCT_DETAIL,
                  arguments: product, // ✅ إرسال المنتج
                );
              },
              child: MyCustomCard(
                imagePath: product.image,
                title: product.name,
                subtitle: product.title,
                price: product.price, // يمكنك لاحقًا جعل السعر جزءًا من المنتج
              ),
            );
          },
        ),
      ),
    );
  }
}
