import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class AddressView extends GetView<CheckoutController> {
  const AddressView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKeyAddress = GlobalKey<FormState>();
    final addressController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: formKeyAddress,
            child: TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Your Address',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => controller.stepIndex.value--,
                child: Text('السابق'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKeyAddress.currentState!.validate()) {
                    controller.address.value = addressController.text;
                    controller.stepIndex.value++;
                  }
                },
                child: Text('التالي'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
