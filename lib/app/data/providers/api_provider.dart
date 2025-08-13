import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'https://wanted-elk-publicly.ngrok-free.app/api',
      baseUrl: 'https://e-commerce-api-fgo8.onrender.com/api',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Dio get dio => _dio;
}
