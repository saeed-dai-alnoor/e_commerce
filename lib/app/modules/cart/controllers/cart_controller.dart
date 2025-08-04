import 'package:e_commerce_app/app/data/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var count = 1.obs;
  var cartItems = <Product>[].obs;
  var favItems = <Product>[].obs;

  void addToFavorites(Product product) {
    if (!favItems.contains(product)) {
      favItems.add(product);
    }
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  void increment() => count++;
  void decrement() {
    if (count > 1) count--;
  }

  @override
  void onInit() {
    // تمثيل بيانات كأنها جاية من السيرفر
    cartItems.addAll([
      Product(
        name: '',
        category: '',
        title: 'ساعة يد فاخرة',
        price: 'ساعة بعقارب جلدية',
        image: 'assets/images/watch.png',
      ),
      Product(
        category: '',
        name: '',
        title: 'حذاء رياضي',
        price: 'حذاء مريح للجري',
        image: 'assets/images/watch.png',
      ),
      Product(
        category: '',
        name: '',
        title: 'حذاء رياضي',
        price: 'حذاء مريح للجري',
        image: 'assets/images/watch.png',
      ),
      Product(
        category: '',
        name: '',
        title: 'حذاء رياضي',
        price: 'حذاء مريح للجري',
        image: 'assets/images/watch.png',
      ),
      Product(
        category: '',
        name: '',
        title: 'حذاء رياضي',
        price: 'حذاء مريح للجري',
        image: 'assets/images/watch.png',
      ),
      Product(
        category: '',
        name: '',
        title: 'حذاء رياضي',
        price: 'حذاء مريح للجري',
        image: 'assets/images/watch.png',
      ),
    ]);
    super.onInit();
  }
}
