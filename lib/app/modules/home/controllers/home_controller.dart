// ignore_for_file: library_prefixes

import 'package:e_commerce_app/app/data/models/product/all_products_model.dart';
import 'package:e_commerce_app/app/data/repositories/product/all_products_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends GetxController {
  late IO.Socket socket;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  final AllProductsRepository repository = AllProductsRepository();
  var allProducts = <AllProductsModel>[].obs;
  var filteredProducts = <AllProductsModel>[].obs;
  final storage = GetStorage();
  final storageKey = 'allProducts';

  var selectedIndex = 0.obs;
  late PageController pageController;
  final searchController = TextEditingController();

  // ------------------- FETCHPRODUCTS METHOD -------------------
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true; // بداية التحميل
      // 1️⃣ جلب البيانات من GetStorage أولاً
      final storedData = storage.read(storageKey);
      if (storedData != null) {
        // تحويل JSON إلى List<AllProductsModel>
        final List<AllProductsModel> productsFromStorage = (storedData as List)
            .map((e) => AllProductsModel.fromJson(e))
            .toList();
        allProducts.value = productsFromStorage;
        filteredProducts.value = productsFromStorage;
      }

      // 2️⃣ جلب البيانات من API
      final productsFromApi = await repository.fetchAllProducts();
      allProducts.value = productsFromApi;
      filteredProducts.value = productsFromApi;

      // 3️⃣ تخزين البيانات في GetStorage
      storage.write(
        storageKey,
        productsFromApi.map((e) => e.toJson()).toList(),
      );
    } catch (e) {
      // هنا ممكن تضيف رسالة خطأ تظهر للمستخدم
      print("Error fetching products: $e");
      // Get.snackbar("Error", 'Unable To Tech Products Check Your Internet!');
    } finally {
      isLoading.value = false; // انتهى التحميل
    }
  }

  List<String> get uniqueCategories {
    return allProducts.map((p) => p.category).toSet().toList();
  }

  // ------------------- productsWithoutFirstOfEachCategory METHOD -------------------
  List<AllProductsModel> get productsWithoutFirstOfEachCategory {
    Map<String, bool> categoryFirstSeen = {};
    List<AllProductsModel> filtered = [];

    for (var product in allProducts) {
      if (categoryFirstSeen[product.category] == true) {
        filtered.add(product);
      } else {
        categoryFirstSeen[product.category] = true;
      }
    }

    return filtered;
  }

  // ------------------- ONSEARCH METHOD -------------------
  void onSearch(String query) {
    print('Searching for: $query');
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.value = allProducts
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    print('Filtered count: ${filteredProducts.length}');
  }

  // ------------------- CHANGE PAGE METHOD -------------------
  void changePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  // ------------------- SOCKET.IO -------------------
  void initSocket() {
    socket = IO.io(
      'https://e-commerce-api-fgo8.onrender.com',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      print('Socket connected');
    });

    socket.on('productUpdated', (data) async {
      print('Received product update: $data');
      await fetchProducts();
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });

    socket.onError((error) {
      print('Socket error: $error');
    });
  }

  // ------------------- ONINIT METHOD -------------------
  @override
  void onInit() {
    super.onInit();
    filteredProducts.value = allProducts;
    pageController = PageController(initialPage: selectedIndex.value);
    fetchProducts();
    initSocket();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    socket.dispose();
  }
}
