import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:e_commerce_app/app/widgets/my_custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
        () => AnimationLimiter(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 315,
              crossAxisSpacing: 10,
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
                child: SizedBox(
                  height: 300,
                  width: 160,
                  child: MyCustomCard(
                    imagePath: product.imgUrl,
                    title: product.name,
                    subtitle: product.category,
                    price: product.price
                        .toString(), // يمكنك لاحقًا جعل السعر جزءًا من المنتج
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
