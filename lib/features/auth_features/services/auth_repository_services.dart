import 'package:dio/dio.dart';
import 'package:onlinemovieplatform/features/auth_features/services/auth_api_services.dart';

class AuthRepositoryServices {
  final AuthApiServices _apiServices = AuthApiServices();
  Future<String?> callAuthApi(String phoneNumber)async{
    final Response response = await _apiServices.callAuthApi(phoneNumber);
    final String? token = response.data['token'];
    return token;
  }
}