import 'package:e_commerce_app/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customRadioTile({
  required String title,
  required String subtitle,
  required DeliveryOption value,
  required Rx<DeliveryOption> groupValue,
}) {
  return Obx(
    () => ListTile(
      onTap: () => groupValue.value = value,
      contentPadding: EdgeInsets.symmetric(vertical: 15),

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8), // <-- هذه المسافة بين العنوان والوصف
          Text(subtitle, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
      trailing: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: groupValue.value == value ? Colors.green : Colors.grey,
            width: 0.8,
          ),
          color: groupValue.value == value ? Colors.green : Colors.grey[200],
        ),
      ),
    ),
  );
}
