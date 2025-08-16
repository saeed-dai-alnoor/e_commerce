import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/repositories/order/order_creator_repository.dart';

class PaymentView extends GetView {
  final String paymentUrl;
  final String orderId;
  final String token;
  const PaymentView({
    super.key,
    required this.paymentUrl,
    required this.orderId,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    final orderRepo = OrderCreatorRepository();

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(paymentUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) async {
            if (url.contains("/payment/success")) {
              // تحقق من حالة الدفع عند النجاح
              await orderRepo.getOrderStatus(orderId: orderId, token: token);
              Get.back(); // ارجع للصفحة السابقة
              Get.snackbar("Success", "Payment Completed Successfully");
            } else if (url.contains("/payment/failed")) {
              Get.back();
              Get.snackbar("Failed", "Payment Failed, try again!");
            }
          },
        ),
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Payment"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(CupertinoIcons.back),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
