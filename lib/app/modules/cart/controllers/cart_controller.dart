import 'package:e_commerce_app/app/data/models/product/all_products_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var cartItems = <AllProductsModel>[].obs;
  var favItems = <AllProductsModel>[].obs;
  var favoriteStatus = <String, bool>{}.obs; // المفتاح id المنتج
  final storage = GetStorage(); // إنشاء تخزين محلي
  final storageKey = "cart_data"; // اسم المفتاح

  void saveCartToStorage() {
    List<Map<String, dynamic>> cartData = cartItems
        .map((item) => item.toJson())
        .toList();
    storage.write(storageKey, cartData);
  }

  void loadCartFromStorage() {
    List? storedData = storage.read(storageKey);
    if (storedData != null) {
      cartItems.assignAll(
        storedData.map((json) => AllProductsModel.fromJson(json)).toList(),
      );
    }
  }

  void clearCart() {
    cartItems.clear();
    storage.remove(storageKey); // مسح من التخزين
  }

  void addToFavorites(AllProductsModel product) {
    if (!favItems.contains(product)) {
      favItems.add(product);
    }
  }

  void removeFromCart(AllProductsModel product) {
    cartItems.remove(product);
    favoriteStatus.remove(product.id);
    saveCartToStorage(); // تحديث التخزين بعد الإضافة
  }

  void addToCart(AllProductsModel product, {bool isFavorite = false}) {
    var existingProduct = cartItems.firstWhereOrNull((p) => p.id == product.id);
    if (existingProduct != null) {
      increment(existingProduct);
    } else {
      product.quantity = 1; // الكمية الافتراضية
      favoriteStatus[product.id] = isFavorite;
      cartItems.add(product);
    }
    saveCartToStorage(); // تحديث التخزين بعد الإضافة
  }

  void toggleFavoriteStatusInCart(AllProductsModel product) {
    if (favoriteStatus.containsKey(product.id)) {
      favoriteStatus[product.id] = !favoriteStatus[product.id]!;
    }
  }

  // دالة زيادة الكمية للمنتج المحدد
  void increment(AllProductsModel product) {
    var existingProduct = cartItems.firstWhereOrNull((p) => p.id == product.id);

    if (existingProduct != null) {
      existingProduct.quantity++;
      cartItems.refresh();
      saveCartToStorage();
    }
  }

  // دالة تقليل الكمية للمنتج المحدد (لا تقل عن 1)
  void decrement(AllProductsModel product) {
    if (product.quantity > 1) {
      product.quantity--;
      cartItems.refresh();
      saveCartToStorage();
    }
  }

  // حساب السعر الإجمالي للسلة
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage(); // تحميل السلة عند بدء التشغيل
  }
}
