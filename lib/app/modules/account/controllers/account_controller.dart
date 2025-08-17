import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/order_status_model.dart';

class AccountController extends GetxController {
  var showShippingPage = false.obs;
  var showTrackCardPage = false.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userImage = Rx<File?>(null); // لتخزين الصورة المختارة
  var userPassword = ''.obs; // لتخزين كلمة السر مؤقتاً
  final storage = GetStorage();
  final picker = ImagePicker();
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
    userName.value = storage.read('name') ?? 'Guest User';
    userEmail.value = storage.read('email') ?? 'guest@example.com';
    userPassword.value = storage.read('password') ?? '';
    final imagePath = storage.read('userImagePath');
    if (imagePath != null) userImage.value = File(imagePath);
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userImage.value = File(pickedFile.path);
      storage.write('userImagePath', pickedFile.path);
    }
  }

  bool checkOldPassword(String oldPassword) {
    return oldPassword == userPassword.value;
  }

  void updatePassword(String newPassword) {
    userPassword.value = newPassword;
    storage.write('password', newPassword);
  }

  void updateName(String newName) {
    userName.value = newName;
    storage.write('name', newName);
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
