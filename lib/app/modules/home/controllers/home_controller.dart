import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final allProducts = <Product>[
    Product(name: "Men", image: "assets/images/menShoe.png"),
    Product(name: "Women", image: "assets/images/womenShoe.png"),
    Product(name: "Devices", image: "assets/images/devices.png"),
    Product(name: "Gadgets", image: "assets/images/gadgets.png"),
    Product(name: "Games", image: "assets/images/gaming.png"),
  ];

  // المنتجات المعروضة حسب البحث
  var filteredProducts = <Product>[].obs;

  void onSearch(String query) {
    if (query.isEmpty) {
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.value = allProducts
          .where((p) => p.name.contains(query))
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    filteredProducts.value = allProducts;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
   var selectedIndex = 0.obs;

  // ممكن تضيف صفحات هنا لو حبيت تستخدم PageView:
  // final pages = [ExploreView(), StoreView(), ProfileView()];
}

class Product {
  final String name;
  final String image;

  Product({required this.name, required this.image});
}
