import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class OdView extends GetView<AccountController> {
  const OdView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(CupertinoIcons.back),
        ),
        automaticallyImplyLeading: false,
        title: const Text('OD - 424923192 - N'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/images/map.png'),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.steps.length,
          itemBuilder: (context, index) {
            final step = controller.steps[index];
            final isLast = index == controller.steps.length - 1;

            return Stack(
              children: [
                /// المحتوى
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// الدائرة
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: step.isDone ? Colors.green : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: step.isDone
                            ? Colors.green
                            : Colors.white,
                      ),
                    ),

                    const SizedBox(width: 16),

                    /// النصوص
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.date,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          step.subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),

                /// الخط العمودي
                if (!isLast)
                  Positioned(
                    left: 14,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: step.isDone ? Colors.green : Colors.grey.shade300,
                    ),
                  ),
              ],
            );
          },
        );
      }),
    );
  }
}
