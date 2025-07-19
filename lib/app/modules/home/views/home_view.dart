import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: controller.searchController,
                onChanged: controller.onSearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Categories',
                style: GoogleFonts.inder(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 28),
              // ✅ Scroll horizontally
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: controller.filteredProducts.map((product) {
                      return Container(
                        margin: const EdgeInsets.only(
                          right: 12,
                        ), // مسافة بين العناصر
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              product.image,
                              width: 32,
                              height: 32,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              height: 22,
                            ), // ✅ المسافة بين الصورة والنص

                            Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Best Selling',
                      style: GoogleFonts.inder(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: GoogleFonts.inder(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Image.asset(
                              'assets/images/set.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 120, // ✅ ثابت لكل النصوص
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BeoPlay Speaker',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bang and Olufsen',
                                style: GoogleFonts.inter(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$755',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: Color(0xFF00C569),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Image.asset(
                              'assets/images/watch.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 120, // ✅ نفس الارتفاع هنا
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Leather Wristwatch',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tag Heuer',
                                style: GoogleFonts.inter(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$450',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: Color(0xFF00C569),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
            // هنا تقدر تغير الصفحة بناءً على index لو استخدمت PageView مثلاً
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(
                Text(
                  'Explore',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                0,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(
                Icon(Icons.local_grocery_store_outlined, color: Colors.black),
                1,
              ),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(
                Icon(Icons.person_outline, color: Colors.black),
                2,
              ),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }

  Widget _buildNavIcon(Widget iconData, int index) {
    final isSelected = Get.find<HomeController>().selectedIndex.value == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconData,
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
