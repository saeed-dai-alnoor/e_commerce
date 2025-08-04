import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  late PageController pageController;
  final searchController = TextEditingController();
  List<String> get uniqueCategories {
    return allProducts.map((p) => p.category).toSet().toList();
  }

  final allProducts = <Product>[
    Product(
      name: "Men",
      title: "one",
      image: "assets/images/menShoe.png",
      price: "\$${'23'}",
      category: "Men",
    ),
    Product(
      name: "Deo Play",
      title: "two",
      image: "assets/images/deoPlay.png",
      price: "\$${'23'}",
      category: "Men",
    ),
    Product(
      name: "Dask Lamp",
      title: "Three",
      image: "assets/images/daskLamp.png",
      price: "\$${'23'}",
      category: "Men",
    ),
    Product(
      name: "Phonecase",
      title: "four",
      image: "assets/images/phoneCase.png",
      price: "\$${'23'}",
      category: "Men",
    ),
    Product(
      name: "Watch",
      title: "five",
      image: "assets/images/watch.png",
      price: "\$${'23'}",
      category: "Men",
    ),
    Product(
      name: "Women",
      title: "six",
      image: "assets/images/womenShoe.png",
      price: "\$${'23'}",
      category: "Women",
    ),
    Product(
      name: "Devices",
      title: "seven",
      image: "assets/images/devices.png",
      price: "\$${'23'}",
      category: "Devices",
    ),
    Product(
      name: "Gadgets",
      title: "eight",
      image: "assets/images/gadgets.png",
      price: "\$${'23'}",
      category: "Gadgets",
    ),
    Product(
      name: "Games",
      title: "nine",
      image: "assets/images/gaming.png",
      price: "\$${'23'}",
      category: "Games",
    ),
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

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    filteredProducts.value = allProducts;
    pageController = PageController(initialPage: selectedIndex.value);
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
