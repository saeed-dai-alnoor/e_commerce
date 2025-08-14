import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';

class AddressView extends GetView<CheckoutController> {
  const AddressView({super.key});
  @override
  Widget build(BuildContext context) {
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

          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKeyAddress,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.street1Controller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Street 1';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Street 1'),
                      onChanged: (_) => controller.validateForm(),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.street2Controller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Street 2';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Street 2'),
                      onChanged: (_) => controller.validateForm(),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.cityController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter City';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'City'),
                      onChanged: (_) => controller.validateForm(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          height: 50,
                          child: TextFormField(
                            controller: controller.stateController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter State';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'State'),
                            onChanged: (_) => controller.validateForm(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 130,
                          height: 50,
                          child: TextFormField(
                            controller: controller.countryController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Country';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Country'),
                            onChanged: (_) => controller.validateForm(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const Spacer(),
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
              Obx(() {
                final isFormValid = controller.isFormValid.value;
                return ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                          // حفظ البيانات
                          controller.street1.value =
                              controller.street1Controller.text;
                          controller.street2.value =
                              controller.street2Controller.text;
                          controller.city.value =
                              controller.cityController.text;
                          controller.state.value =
                              controller.stateController.text;
                          controller.country.value =
                              controller.countryController.text;

                          controller.stepIndex.value++;
                        }
                      : null, // معطل لو الفورم غير صالح
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
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
