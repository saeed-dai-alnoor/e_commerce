import 'package:e_commerce_app/app/modules/account/views/account_view.dart';
import 'package:e_commerce_app/app/modules/cart/views/cart_view.dart';
import 'package:e_commerce_app/app/modules/home/views/home_page_view.dart';
import 'package:e_commerce_app/app/widgets/build_nav_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView(
          controller: controller.pageController,
          onPageChanged: (index) => controller.selectedIndex.value = index,
          children: const [HomePageView(), CartView(), AccountView()],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
              icon: buildNavIcon(
                icon: Icons.storefront_outlined,
                label: 'Explore',
                index: 0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: buildNavIcon(
                icon: Icons.shopping_cart_outlined,
                label: 'Cart',
                index: 1,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: buildNavIcon(
                icon: Icons.person_outline,
                label: 'Account',
                index: 2,
              ),
              label: 'Account',
            ),
          ],
        );
      }),
    );
  }
}
