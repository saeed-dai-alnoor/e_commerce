import 'dart:convert';

import 'package:e_commerce_app/app/data/models/product/all_products_model.dart';
import 'package:e_commerce_app/app/data/repositories/product/all_products_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends GetxController {
  // late IOWebSocketChannel channel;
  late IO.Socket socket;

  var isLoading = true.obs;

  final AllProductsRepository repository = AllProductsRepository();
  var allProducts = <AllProductsModel>[].obs;
  var filteredProducts = <AllProductsModel>[].obs;

  var selectedIndex = 0.obs;
  late PageController pageController;
  final searchController = TextEditingController();

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true; // بداية التحميل
      final productsFromApi = await repository.fetchAllProducts();
      allProducts.value = productsFromApi;
      filteredProducts.value = productsFromApi;
    } catch (e) {
      // هنا ممكن تضيف رسالة خطأ تظهر للمستخدم
      print("Error fetching products: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false; // انتهى التحميل
    }
  }

  List<String> get uniqueCategories {
    return allProducts.map((p) => p.category).toSet().toList();
  }

  List<AllProductsModel> get productsWithoutFirstOfEachCategory {
    Map<String, bool> categoryFirstSeen = {};
    List<AllProductsModel> filtered = [];

    for (var product in allProducts) {
      if (categoryFirstSeen[product.category] == true) {
        // لو شفنا الفئة قبل كدا، نضيف المنتج
        filtered.add(product);
      } else {
        // أول مرة نشوف الفئة، نعلم بس ما نضيف المنتج
        categoryFirstSeen[product.category] = true;
      }
    }

    return filtered;
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.value = allProducts
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
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
    fetchProducts(); // استدعي هنا جلب المنتجات من API

    // فتح اتصال WebSocket
    // channel = IOWebSocketChannel.connect(
    //   'wss://wanted-elk-publicly.ngrok-free.app:5000',
    // );

    // channel.stream.listen(
    //   (message) async {
    //     final data = jsonDecode(message);

    //     switch (data['action']) {
    //       case 'create':
    //       case 'update':
    //       case 'delete':
    //         // أي تغيير يأتي من السيرفر، أعِد جلب كامل البيانات من API لتحديث القوائم
    //         await fetchProducts();
    //         break;

    //       default:
    //         break;
    //     }
    //   },
    //   onError: (error) {
    //     print('WebSocket error: $error');
    //   },
    // );
    // إعداد اتصال socket.io
    socket = IO.io(
      'https://wanted-elk-publicly.ngrok-free.app', // بدون بورت، لأنه socket.io يشتغل على نفس البورت الافتراضي 5000
      IO.OptionBuilder()
          .setTransports(['websocket']) // استخدام بروتوكول websocket فقط
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      print('Socket connected');
    });

    socket.on('productUpdated', (data) async {
      print('Received product update: $data');
      await fetchProducts(); // إعادة تحميل المنتجات عند أي تحديث
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });

    socket.onError((error) {
      print('Socket error: $error');
    });
  }

  @override
  void onClose() {
    super.onClose();
    // channel.sink.close();
    socket.dispose();
    searchController.dispose();
  }
}
