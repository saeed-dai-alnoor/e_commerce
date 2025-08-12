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
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/saeed.jpeg'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Saeed Dai Alnoor',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('saeeddaialnoor@gmail.com'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        buildListTile(
                          'Edit Profile',
                          Image.asset('assets/images/edit.png'),
                          onTap: () {},
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
