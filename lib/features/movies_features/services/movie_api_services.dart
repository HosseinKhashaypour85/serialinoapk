import 'package:dio/dio.dart';
import 'package:onlinemovieplatform/const/connection.dart';

class MovieApiServices {
  final Dio _dio = Dio();

  Future<Response> callAllMoviesApi(String movieId) async {
    final Response response = await _dio.get(
      'https://hosseinkhashaypour.chbk.app/api/collections/movies/records',
      queryParameters: {
       'filter' : 'id = "$movieId"',
      },
    );
    return response;
  }
}
