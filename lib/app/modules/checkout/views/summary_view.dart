import 'package:e_commerce_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SummaryView extends GetView<CheckoutController> {
  const SummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => ListTile(
              title: Text('Delivery Method'),
              subtitle: Text(controller.selectedOption.value.name.capitalize!),
            ),
          ),
          Obx(
            () => ListTile(
              title: Text('Address'),
              subtitle: Text(controller.address.value),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => controller.stepIndex.value--,
                child: Text('السابق'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar('Order', 'Order Confirmed!');
                },
                child: Text('تأكيد الطلب'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
