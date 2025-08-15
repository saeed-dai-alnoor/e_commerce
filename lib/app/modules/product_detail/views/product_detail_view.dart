import 'package:e_commerce_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final product = controller.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.25,
        ), // ربع الشاشة
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(color: Color(0xFFdfdfdf)),
          child: SafeArea(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر الرجوع
                  IconButton(
                    icon: const Icon(CupertinoIcons.back, color: Colors.black),
                    onPressed: () => Get.back(),
                    iconSize: 20,
                  ),

                  // صورة المنتج في المنتصف
                  Expanded(
                    child: Center(
                      child: Image.network(
                        width: 300,
                        height: 300,
                        controller.product.imgUrl,
                        fit: BoxFit.fill,
                        loadingBuilder:
                            (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error); // صورة بديلة عند الفشل
                        },
                      ),
                    ),
                  ),

                  // أيقونة النجمة
                  Obx(
                    () => GestureDetector(
                      onTap: controller.toggleFavorite,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          controller.isFavorite.value
                              ? Icons.star
                              : Icons.star_border,
                          color: controller.isFavorite.value
                              ? Colors.amber
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // العنوان
            const Text(
              "Details:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // تفاصيل المنتج
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:   ${product.name}"),
                  const SizedBox(height: 8),
                  Text("Description:   ${product.description}"),
                  const SizedBox(height: 8),
                  Text("Category:   ${product.category}"),
                  const SizedBox(height: 8),
                  Text("Price:   \$${product.price}"),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Price", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                final cartController = Get.find<CartController>();

                cartController.addToCart(
                  controller.product,
                  isFavorite: controller
                      .isFavorite
                      .value, // حالة النجمة من صفحة التفاصيل
                );
                // cartController.addToCart(controller.product);
                Get.snackbar("Add Successfully", "Add Product Done!");
              },
              child: const Text("ADD", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
