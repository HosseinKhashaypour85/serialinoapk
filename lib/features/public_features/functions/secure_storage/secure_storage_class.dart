import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageClass{
  Future<String?> getUserToken()async{
    final token = await const FlutterSecureStorage().read(key: 'token');
    return token;
  }
  Future<String?>getUserSubToken()async{
    final subToken = await const FlutterSecureStorage().read(key: 'subToken');
  }
  Future<void>saveUserToken(token)async{
   await const FlutterSecureStorage().write(key: 'token', value: token);
  }
  Future<void>deleteUserToken()async{
    await const FlutterSecureStorage().delete(key: 'token');
  }
}