import 'package:dio/dio.dart';
import 'package:e_commerce_app/app/data/models/auth/sign_up_model.dart';
import 'package:e_commerce_app/app/data/providers/api_provider.dart';

class SignupRepository {
  final ApiProvider apiProvider = ApiProvider();

  Future<Response> signupUser(SignUpModel userData) async {
    try {
      final response = await apiProvider.dio.post(
        '/auth/signup',
        data: userData.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw e.response?.data ?? {"message": "Signup failed"};
    }
  }
}
