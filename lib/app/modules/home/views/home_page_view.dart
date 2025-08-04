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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 30),
            Text(
              'Categories',
              style: GoogleFonts.inder(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.uniqueCategories.map((category) {
                  final image = controller.allProducts
                      .firstWhere((p) => p.category == category)
                      .image;

                  return GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.CATEGORY_RESULT,
                      arguments: category,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          Image.asset(image, width: 32, height: 32),
                          const SizedBox(height: 8),
                          Text(category, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Best Selling',
                  style: GoogleFonts.inder(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See all',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: MyCustomCard(
                    imagePath: 'assets/images/set.png',
                    title: 'BeoPlay Speaker',
                    subtitle: 'Bang and Olufsen',
                    price: '\$755',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MyCustomCard(
                    imagePath: 'assets/images/watch.png',
                    title: 'Leather Wristwatch',
                    subtitle: 'Tag Heuer',
                    price: '\$450',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
