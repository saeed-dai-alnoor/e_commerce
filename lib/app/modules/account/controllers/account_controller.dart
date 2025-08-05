import 'package:get/get.dart';

import '../../../data/models/order_status_model.dart';

class AccountController extends GetxController {
  var showShippingPage = false.obs;
  var showTrackCardPage = false.obs;
  final steps = <OrderStatusModel>[
    OrderStatusModel(
      title: 'Order Signed',
      subtitle: 'Lagos State, Nigeria',
      date: '20/18\n10:00 AM',
      isDone: true,
    ),
    OrderStatusModel(
      title: 'Order Processed',
      subtitle: 'Lagos State, Nigeria',
      date: '20/18\n10:00 AM',
      isDone: true,
    ),
    OrderStatusModel(
      title: 'Shipped',
      subtitle: 'Lagos State, Nigeria',
      date: '21/18\n10:00 AM',
      isDone: true,
    ),
    OrderStatusModel(
      title: 'Out for delivery',
      subtitle: 'Edo State, Nigeria',
      date: '',
      isDone: false,
    ),
    OrderStatusModel(
      title: 'Delivered',
      subtitle: 'Edo State, Nigeria',
      date: '',
      isDone: false,
    ),
  ].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
