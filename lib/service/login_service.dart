import 'dart:developer';

import 'package:dio/dio.dart';

class LoginService {
  Dio dio = Dio();
  Future login(String email, String password) async {
    final response = await dio.post("http://10.0.162.104:8000/api/login", data: {
      "email":email,
      "password":password
    });
    log(response.data.toString());
  }
}