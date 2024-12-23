import 'dart:developer';
import 'package:dio/dio.dart';

class LoginService {
  Dio dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(
        "http://172.20.10.3:8000/api/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      log(response.data.toString());
      return {
        "success": true,
        "data": response.data,
      };
    } on DioError catch (e) {
      log(e.response?.data.toString() ?? "Unknown error");
      return {
        "success": false,
        "message": e.response?.data['message'] ?? "Login failed",
      };
    }
  }
}
