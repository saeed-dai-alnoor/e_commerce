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
          const SizedBox(height: 28),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/images/set.png'),
                    ),
                    Text('BeoPlay Speaker'),
                    Text('\$755', style: TextStyle(color: Color(0xFF00C569))),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/images/watch.png'),
                    ),
                    Text('BeoPlay Speaker'),
                    Text('\$755', style: TextStyle(color: Color(0xFF00C569))),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset('assets/images/deoPlay.png'),
                    ),
                    Text('BeoPlay Speaker'),
                    Text('\$755', style: TextStyle(color: Color(0xFF00C569))),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 34),
          Text(
            'Shipping Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '21, Alex Davidson Avenue, Opposite ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Omegatron, Vicent Smith Quarters,',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),

              Text(
                'Victoria Island, Lagos, Nigeria',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
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
