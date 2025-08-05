import 'package:e_commerce_app/app/widgets/my_custom_radio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class DeliveryView extends GetView<CheckoutController> {
  const DeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = ['Delivery', 'Address', 'Summary'];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          // للدوائر بتاعت المراحل
          Row(
            children: List.generate(steps.length, (index) {
              final isActive = index == 0;
              final isPassed = index < 0;
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // الخط قبل الدائرة
                        if (index != 0)
                          Expanded(
                            child: Container(
                              height: 2,
                              color: isPassed
                                  ? Color(0xFF00C569)
                                  : Colors.grey.shade300,
                            ),
                          ),
                        // الدائرة نفسها
                        Column(
                          children: [
                            Container(
                              width: 27,
                              height: 27,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isActive || isPassed
                                      ? Color(0xFF00C569)
                                      : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive || isPassed
                                        ? Color(0xFF00C569)
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // الخط بعد الدائرة
                        if (index != steps.length - 1)
                          Expanded(
                            child: Container(
                              height: 2,
                              color: index < 0
                                  ? Color(0xFF00C569)
                                  : Colors.grey.shade300,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              final isActive = index == 0;
              return Text(
                steps[index],
                style: TextStyle(
                  fontSize: 16,
                  color: isActive ? Colors.black : Colors.black45,
                ),
              );
            }),
          ),

          const SizedBox(height: 40),
          customRadioTile(
            title: 'Standard Delivery',
            subtitle: 'Order will be delivered between 3 - 5 business days',
            value: DeliveryOption.standard,
            groupValue: controller.selectedOption,
          ),
          customRadioTile(
            title: 'Next Day Delivery',
            subtitle:
                'Place your order before 6pm and your items will be delivered the next day',
            value: DeliveryOption.nextDay,
            groupValue: controller.selectedOption,
          ),
          customRadioTile(
            title: 'Nominated Delivery',
            subtitle:
                'Pick a particular date from the calendar and order will be delivered on selected date',
            value: DeliveryOption.nominated,
            groupValue: controller.selectedOption,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () => controller.stepIndex.value++,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C569),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    3,
                  ), // <-- هنا تتحكم في الاستدارة
                ),
                padding: EdgeInsets.symmetric(vertical: 23, horizontal: 57),
              ),
              child: Text('NEXT', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
