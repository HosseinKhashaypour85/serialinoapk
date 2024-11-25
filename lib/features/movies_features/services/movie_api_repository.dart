import 'package:http/http.dart';
import 'package:onlinemovieplatform/features/movies_features/model/movie_model.dart';
import 'package:onlinemovieplatform/features/movies_features/services/movie_api_services.dart';

class MovieApiRepository {
  final MovieApiServices _apiServices = MovieApiServices();
  Future<MovieModel>callAllMoviesApi(String movieId)async{
    final response = await _apiServices.callAllMoviesApi(movieId);
    MovieModel movieModel = MovieModel.fromJson(response.data);
    return movieModel;
  }
}