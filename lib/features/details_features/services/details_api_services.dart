import 'package:dio/dio.dart';
import 'package:onlinemovieplatform/const/connection.dart';

class DetailsApiServices {
  final Dio _dio = Dio();

  Future<Response> callDetailsApi(String category) async {
    final Response response = await _dio.get(
      'https://hosseinkhashaypour.chbk.app/api/collections/movies/records',
      queryParameters: {
        'filter': 'category = "$category"',
      },
    );
    return response;
  }
}
