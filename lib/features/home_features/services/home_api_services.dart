import 'package:dio/dio.dart';
import 'package:onlinemovieplatform/const/connection.dart';

class HomeApiServices {
  final Dio _dio = Dio();

  Future<Response> callHomeApi() async {
    final Response response = await _dio.get('$apiUrl');
    return response;
  }

//   carousel sliders api
  Future<Response> callCarouselApi() async {
    final Response response = await _dio.get(carouselUrl);
    return response;
  }

//  movies slider section
  Future<Response> callMovieSliderSectionApi() async {
    final Response response = await _dio.get('$mainUrl/movies/records');
    return response;
  }
}
