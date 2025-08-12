import 'dart:ui';
import 'package:e_commerce_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryView extends GetView<CheckoutController> {
  const SummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          Obx(() {
            if (cartController.cartItems.isEmpty) {
              return const Center(child: Text("No items in cart"));
            }

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse, // دعم الماوس
                },
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: cartController.cartItems.map((product) {
                    return Card(
                      margin: const EdgeInsets.only(right: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: 120,
                        height: 180,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.imgUrl,
                                height: 80,
                                width: 70,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Qty: ${product.quantity}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${(product.price * product.quantity).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF00C569),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          Text(
            'Delivery Method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Obx(() {
            String deliveryText = '';
            switch (controller.selectedOption.value) {
              case DeliveryOption.standard:
                deliveryText = 'Standard Delivery (3 - 5 business days)';
                break;
              case DeliveryOption.nextDay:
                deliveryText = 'Next Day Delivery';
                break;
              case DeliveryOption.nominated:
                deliveryText = 'Nominated Delivery';
                break;
            }
            return Text(
              deliveryText,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            );
          }),
          const SizedBox(height: 12),

          Text(
            'Shipping Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  "${controller.street1.value}, ${controller.street2.value}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () =>
                    Text(controller.city.value, style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  "${controller.state.value}, ${controller.country.value}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 6),
              Obx(() {
                final subtotal = cartController.totalPrice;
                final tax = controller.calculateTax(subtotal);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subtotal:  \$${subtotal.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "Delivery:  \$${controller.deliveryPrice.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "Tax (15%):  \$${tax.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Total Price:   ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    final subtotal = cartController.totalPrice;
                    final total = controller.calculateTotal(subtotal);
                    return Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF00C569),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  controller.stepIndex.value =
                      0; // ترجع للمرحلة الأولى (Delivery)
                },
                child: Text(
                  'Change',
                  style: TextStyle(fontSize: 17, color: Color(0xFF00C569)),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => controller.stepIndex.value--,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 1.5, color: Color(0xFF00C569)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),

                  padding: EdgeInsets.symmetric(vertical: 23, horizontal: 57),
                ),
                child: Text('BACK', style: TextStyle(color: Colors.black)),
              ),

              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar('Order', 'Order Confirmed!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00C569),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      3,
                    ), // <-- هنا تتحكم في الاستدارة
                  ),
                  padding: EdgeInsets.symmetric(vertical: 23, horizontal: 57),
                ),
                child: Text('Deliver', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
