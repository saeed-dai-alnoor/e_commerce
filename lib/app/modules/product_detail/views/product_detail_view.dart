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
      backgroundColor: Colors.transparent,
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
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage(controller.product.image),
                            fit: BoxFit.contain,
                          ),
                        ),
                        // child: Image.asset(controller.product.image),
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
              decoration: BoxDecoration(
                // color: Colors.grey[900],
                // borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:   ${product.title}"),
                  const SizedBox(height: 8),
                  Text("Title:   ${product.title}"),
                  const SizedBox(height: 8),
                  Text("Category:   ${product.category}"),
                  const SizedBox(height: 8),
                  Text("Price:   \$${product.price}"),
                  // أضف أي تفاصيل أخرى تريدها هنا
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
                Get.snackbar(
                  "تمت الإضافة",
                  "تمت إضافة المنتج بنجاح",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text("ADD", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
