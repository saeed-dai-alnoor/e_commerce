import 'package:dio/dio.dart';
import 'package:e_commerce_app/app/data/providers/api_provider.dart';

class OrderCreatorRepository {
  final ApiProvider apiProvider = ApiProvider();

  // إنشاء أوردر جديد
  Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> shippingAddress,
    String currency = "SAR",
    required String token,
  }) async {
    try {
      final response = await apiProvider.dio.post(
        '/orders/create',
        data: {
          "items": items, // productId + quantity
          "shippingAddress": shippingAddress,
          "currency": currency,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.data; // { orderId, paymentUrl, paymentStatus }
    } on DioException catch (e) {
      throw e.response?.data ?? {"message": "Failed to create order"};
    }
  }

  // جلب حالة الأوردر
  Future<Map<String, dynamic>> getOrderStatus({
    required String orderId,
    required String token,
  }) async {
    try {
      final response = await apiProvider.dio.get(
        '/orders/$orderId/status',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.data; // { orderId, paymentStatus, status }
    } on DioException catch (e) {
      throw e.response?.data ?? {"message": "Failed to get order status"};
    }
  }
}
