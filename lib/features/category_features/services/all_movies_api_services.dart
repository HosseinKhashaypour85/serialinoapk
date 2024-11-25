import 'package:dio/dio.dart';

class AllMoviesApiServices {
  final Dio _dio = Dio();
  Future<Response> callAllMoviesApi()async{
    final Response response = await _dio.get('https://hosseinkhashaypour.chbk.app/api/collections/movies/records');
    return response;
  }
}