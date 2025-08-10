import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_dashboard_controller.dart';

class ProductDashboardView extends GetView<ProductDashboardController> {
  const ProductDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductDashboardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductDashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
