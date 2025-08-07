import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';

class AddressView extends GetView<CheckoutController> {
  const AddressView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKeyAddress = GlobalKey<FormState>();
    final addressController = TextEditingController();
    final steps = ['Delivery', 'Address', 'Summary'];
    int currentStep = 1; // المرحلة الحالية (مثلاً الثانية)

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          // للدوائر بتاعت المراحل
          Row(
            children: List.generate(steps.length, (index) {
              final isFilled = index <= currentStep; // داخلها لون أخضر
              final isBorderGreen =
                  index == currentStep; // الحد الخارجي أخضر فقط للدائرة الحالية

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
                              color: index <= currentStep
                                  ? Color(0xFF00C569)
                                  : Colors.grey.shade300,
                            ),
                          ),

                        // الدائرة نفسها
                        Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isBorderGreen
                                  ? Color(0xFF00C569)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isFilled
                                    ? Color(0xFF00C569)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),

                        // الخط بعد الدائرة
                        if (index != steps.length - 1)
                          Expanded(
                            child: Container(
                              height: 2,
                              color: (index < currentStep)
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
              final isActive = index == currentStep;
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
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset('assets/images/correct.png'),
              ),
              const SizedBox(width: 8),
              Text(
                'Billing address is the same as delivery address',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Form(
            key: formKeyAddress,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: controller.street1Controller,

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Street 1',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.street2Controller,

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Street 2',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.cityController,

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'City',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: TextFormField(
                        controller: controller.stateController,

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'State',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: TextFormField(
                        controller: controller.countryController,

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Country',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,

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
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKeyAddress.currentState!.validate()) {
                    controller.address.value = addressController.text;
                    controller.stepIndex.value++;
                  }
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
                child: Text('NEXT', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
