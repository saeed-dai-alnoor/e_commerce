import 'dart:ui';
import 'package:e_commerce_app/app/modules/home/views/all_products_grid_view_view.dart';
import 'package:e_commerce_app/app/modules/home/views/downloadin_home_view.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:e_commerce_app/app/widgets/my_custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomePageView extends GetView<HomeController> {
  const HomePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        // شاشة تحميل رمادية مع مؤشر تحميل
        return DownloadinHomeView();
      } else {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextField(
                  controller: controller.searchController,
                  onChanged: controller.onSearch,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                  ),
                ),
                // القائمة المنسدلة
                Obx(() {
                  if (controller.searchQuery.value.isEmpty) {
                    return SizedBox.shrink(); // لو ما كتبش حاجة → ما نعرضش حاجة
                  }
                  if (controller.filteredProducts.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Not Found", style: TextStyle(fontSize: 16)),
                    );
                  }

                  return Container(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                    ), // أقصى طول للقائمة
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.filteredProducts[index];
                        return ListTile(
                          leading: Image.network(
                            product.imgUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.category),
                          onTap: () {
                            // نفضي البحث بعد الاختيار
                            Future.microtask(() {
                              controller.searchController.clear();
                              controller.searchQuery.value = '';
                              controller.filteredProducts.value =
                                  controller.allProducts;
                            });

                            // نروح لصفحة التفاصيل
                            Get.toNamed(
                              Routes.PRODUCT_DETAIL,
                              arguments: product,
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(height: 30),
                Text(
                  'Categories',
                  style: GoogleFonts.inder(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 28),
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse, // دعم الماوس
                    },
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: controller.uniqueCategories.map((category) {
                        final image = controller.allProducts
                            .firstWhere((p) => p.category == category)
                            .imgUrl;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Get.toNamed(
                                Routes.CATEGORY_RESULT,
                                arguments: category,
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  category,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Best Selling',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inder(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => AllProductsGridViewView()),
                      child: const Text(
                        'See all',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.productsWithoutFirstOfEachCategory
                          .map((product) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.PRODUCT_DETAIL,
                                  arguments: product, // ✅ إرسال المنتج
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  height: 300,
                                  width: 160,
                                  child: MyCustomCard(
                                    imagePath: product.imgUrl,
                                    title: product.name,
                                    subtitle: product.category,
                                    price: '\$${product.price}',
                                  ),
                                ),
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
