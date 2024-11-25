import 'package:dio/dio.dart';

import '../../../const/connection.dart';

class AuthApiServices {
  final Dio _dio = Dio();

  Future<Response> callAuthApi(String phoneNumber) async {
    final Response response = await _dio.post(
      '$authUrl/login',
      queryParameters: {
        'mobile': phoneNumber,
      },
    );
    return response;
  }
}
