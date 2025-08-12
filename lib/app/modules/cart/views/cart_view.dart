import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:e_commerce_app/app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.cartItems.isEmpty) {
            return const Center(child: Text('Empty Cart!'));
          }

          return ListView.builder(
            itemCount: controller.cartItems.length,
            itemBuilder: (context, index) {
              final product = controller.cartItems[index];
              return Slidable(
                key: ValueKey(product.id),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    CustomSlidableAction(
                      onPressed: (_) {
                        final currentStatus =
                            controller.favoriteStatus[product.id] ?? false;
                        controller.favoriteStatus[product.id] =
                            !currentStatus; // قلب الحالة
                      },
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.white,
                      child: Obx(() {
                        final isFavorite =
                            controller.favoriteStatus[product.id] ?? false;
                        return Icon(
                          Icons.star,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 36,
                        );
                      }),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    CustomSlidableAction(
                      onPressed: (_) => controller.removeFromCart(product),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.delete, color: Colors.white, size: 36),
                    ),
                  ],
                ),
                child: CartItemCard(product: product),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text("Price", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    "\$${controller.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              final  hasItems = controller.cartItems.isNotEmpty;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00C569),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 22,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                onPressed: hasItems
                    ? () {
                        Get.toNamed(Routes.CHECKOUT);
                      }
                    : null, // الزر يكون غير مفعل إذا السلة فاضية

                child: Text("CHECKOUT", style: TextStyle(color: Colors.white)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
