import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:e_commerce_app/app/widgets/my_custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class AllProductsGridViewView extends GetView<HomeController> {
  const AllProductsGridViewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Get.back(),
        ),
        title: const Text('All Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          if (controller.allProducts.isEmpty) {
            return const Center(
              child: Text(
                'No products available',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return AnimationLimiter(
            child: GridView.builder(
              itemCount: controller.allProducts.length - 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 355,
                crossAxisSpacing: 10,
                // childAspectRatio: 0.40, // مربع 160x160
              ),
              itemBuilder: (context, index) {
                final product = controller.allProducts[index + 1];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.PRODUCT_DETAIL,
                            arguments: product, // ✅ إرسال المنتج
                          );
                        },
                        child: SizedBox(
                          width: 160,
                          height: 180,
                          child: MyCustomCard(
                            imagePath: product.imgUrl,
                            title: product.name,
                            subtitle: product.category,
                            price: '\$${product.price}',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
