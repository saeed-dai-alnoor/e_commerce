import 'package:e_commerce_app/app/modules/checkout/views/address_view.dart';
import 'package:e_commerce_app/app/modules/checkout/views/delivery_view.dart';
import 'package:e_commerce_app/app/modules/checkout/views/summary_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, // مهم للسماح بتحريك المحتوى عند ظهور الكيبورد
        appBar: AppBar(
          title: Obx(
            () =>
                Text(controller.stepIndex.value == 2 ? 'Summary' : 'Checkout'),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(CupertinoIcons.back),
          ),
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: controller.stepIndex.value,
                  children: [DeliveryView(), AddressView(), SummaryView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
