import 'package:dio/dio.dart';
import 'package:e_commerce_app/app/data/models/auth/login_model.dart';
import 'package:e_commerce_app/app/data/providers/api_provider.dart';

class LoginRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<Response> loginUser(LoginModel userData) async {
    try {
      final response = await apiProvider.dio.post(
        '/auth/login',
        data: userData.toJson(),
      );

      return response;
    } on DioException catch (e) {
      throw e.response?.data ?? {"message": "Login failed"};
    }
  }
}
