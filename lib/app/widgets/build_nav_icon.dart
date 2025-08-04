import 'package:e_commerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildNavIcon({
  required IconData icon,
  required String label,
  required int index,
}) {
  final isSelected = Get.find<HomeController>().selectedIndex.value == index;

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: isSelected ? Color(0xFF00C569) : Colors.black),
      const SizedBox(height: 4),
      if (isSelected)
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF00C569),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      const SizedBox(height: 2),
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF00C569) : Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    ],
  );
}
