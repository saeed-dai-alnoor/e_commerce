import 'package:dio/dio.dart';
import 'package:e_commerce_app/app/data/models/product/all_products_model.dart';
import 'package:e_commerce_app/app/data/providers/api_provider.dart';

class AllProductsRepository {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<AllProductsModel>> fetchAllProducts() async {
    try {
      final Response response = await apiProvider.dio.get(
        '/products',
      ); // بدون queryParameters

      final data = response.data;

      if (data is List) {
        return data
            .map((e) => AllProductsModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }

      if (data is Map<String, dynamic>) {
        if (data['products'] is List) {
          return (data['products'] as List)
              .map(
                (e) => AllProductsModel.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList();
        }
        if (data['data'] is List) {
          return (data['data'] as List)
              .map(
                (e) => AllProductsModel.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList();
        }
      }

      throw FormatException('Unexpected response format: ${data.runtimeType}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout — تأكد من اتصال الإنترنت.');
      }
      if (e.type == DioExceptionType.badResponse) {
        final code = e.response?.statusCode;
        final msg = e.response?.data ?? e.message;
        throw Exception('Server responded with $code: $msg');
      }
      throw Exception('Failed to fetch products: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
