import 'package:e_commerce_app/app/modules/account/views/od_view.dart';
import 'package:e_commerce_app/app/modules/account/views/shipping_address_view.dart';
import 'package:e_commerce_app/app/modules/account/views/track_order_view.dart';
import 'package:e_commerce_app/app/widgets/build_list_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.showTrackCardPage.value) {
        return TrackOrderView();
      }
      return controller.showShippingPage.value
          ? const ShippingAddressView() // 👈 هنا نعرض View مباشرة
          : Scaffold(
              body: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                image: controller.userImage.value != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          controller.userImage.value!,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/saeed.jpeg',
                                        ), // أيقونة شخص افتراضية
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.userName.value,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Obx(() => Text(controller.userEmail.value)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        buildListTile(
                          'Edit Profile',
                          Image.asset('assets/images/edit.png'),
                          onTap: () {
                            final nameController = TextEditingController(
                              text: controller.userName.value,
                            );
                            final oldPassController = TextEditingController();
                            final newPassController = TextEditingController();

                            Get.defaultDialog(
                              title: 'Edit Profile',
                              content: Column(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      controller.pickImage(); // اختيار صورة
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                        horizontal: 13,
                                      ),
                                      backgroundColor: Colors.grey[500],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    label: const Text(
                                      'Change Profile Picture',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: oldPassController,
                                    decoration: const InputDecoration(
                                      labelText: 'Old Password',
                                    ),
                                    obscureText: true,
                                  ),
                                  TextField(
                                    controller: newPassController,
                                    decoration: const InputDecoration(
                                      labelText: 'New Password',
                                    ),
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 23),
                                ],
                              ),
                              textCancel: 'Cancel', // زر الإلغاء
                              cancelTextColor: Colors.red,
                              textConfirm: 'Save',
                              onConfirm: () {
                                // تحديث الاسم مباشرة
                                controller.updateName(nameController.text);

                                // تحديث كلمة السر بعد التحقق
                                if (oldPassController.text.isNotEmpty &&
                                    newPassController.text.isNotEmpty) {
                                  if (controller.checkOldPassword(
                                    oldPassController.text,
                                  )) {
                                    controller.updatePassword(
                                      newPassController.text,
                                    );
                                    Get.snackbar(
                                      'Success',
                                      'Password updated successfully',
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Old password is incorrect',
                                    );
                                    return; // إذا كانت كلمة السر القديمة خاطئة، لا يغلق الـ Dialog
                                  }
                                }

                                // إغلاق الـ Dialog بعد نجاح التحديث
                                Get.back();
                              },
                            );
                          },
                        ),
                        buildListTile(
                          'Shipping Address',
                          Image.asset('assets/images/location.png'),
                          onTap: () {
                            controller.showShippingPage.value =
                                true; // 👈 التبديل للصفحة
                          },
                        ),
                        buildListTile(
                          'Order History',
                          Image.asset('assets/images/history.png'),
                          onTap: () {
                            Get.to(OdView());
                          },
                        ),
                        buildListTile(
                          'Track Order',
                          Image.asset('assets/images/cart.png'),
                          onTap: () {
                            controller.showTrackCardPage.value = true;
                          },
                        ),
                        buildListTile(
                          'Notification',
                          Image.asset('assets/images/noti.png'),
                          onTap: () {},
                        ),
                        const SizedBox(height: 18),
                        buildListTile(
                          'logout'.tr,
                          Image.asset('assets/images/logout.png'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}

//     return Scaffold(
//       body: Column(
//         children: [
//           // Options List
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             margin: const EdgeInsets.symmetric(
//               horizontal: 12.0,
//               // vertical: 32.0,
//             ),
//             decoration: BoxDecoration(
//               // color: Colors.grey,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey,
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/saeed.jpeg'),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Saeed Dai Alnoor',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text('saeeddaialnoor@gmail.com'),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 90),
//                 buildListTile(
//                   'Edit Profile',
//                   Image.asset('assets/images/edit.png'),
//                   onTap: () {},
//                 ),
//                 buildListTile(
//                   'Shipping Adress',
//                   Image.asset('assets/images/location.png'),
//                   onTap: () {
//                     Get.to(ShippingAddressView());
//                   },
//                 ),
//                 buildListTile(
//                   'Order History',
//                   Image.asset('assets/images/history.png'),
//                   onTap: () {
//                     // Handle terms & conditions
//                   },
//                 ),
//                 buildListTile(
//                   'Cards',
//                   Image.asset('assets/images/cart.png'),
//                   onTap: () {
//                     // Handle privacy policy
//                   },
//                 ),
//                 buildListTile(
//                   'Notification',
//                   Image.asset('assets/images/noti.png'),
//                   onTap: () {},
//                 ), //
//                 const SizedBox(height: 18),
//                 buildListTile(
//                   'logout'.tr,
//                   Image.asset('assets/images/logout.png'),

//                   onTap: () {
//                     // Handle logout
//                   },
//                   // isLogout: true,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
