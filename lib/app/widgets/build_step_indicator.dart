import 'package:flutter/material.dart';

Widget buildStepIndicator(int currentStep) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      3,
      (index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: index == currentStep ? Colors.green : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}
