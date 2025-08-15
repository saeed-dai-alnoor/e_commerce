import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/app/data/models/product/all_products_model.dart';
import 'package:e_commerce_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatelessWidget {
  final AllProductsModel product;

  const CartItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.imgUrl,
                width: 100,
                height: 120,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Icon(
                  Icons.image, // أيقونة صورة
                  size: 60,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image, // أيقونة صورة مكسورة
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    // السعر = سعر المنتج * الكمية
                    '\$${(product.price * product.quantity).toStringAsFixed(2)}',

                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => controller.decrement(product),
                        ),

                        Text(
                          '${product.quantity}',
                          style: const TextStyle(fontSize: 18),
                        ),

                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => controller.increment(product),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
