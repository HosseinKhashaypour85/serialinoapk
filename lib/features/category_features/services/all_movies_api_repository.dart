import 'package:http/http.dart';
import 'package:onlinemovieplatform/features/category_features/model/all_movies_model.dart';
import 'package:onlinemovieplatform/features/category_features/services/all_movies_api_services.dart';

class AllMoviesApiRepository {
  final AllMoviesApiServices _apiServices = AllMoviesApiServices();
  Future<AllMoviesModel> callAllMoviesApi()async{
    final response = await _apiServices.callAllMoviesApi();
    AllMoviesModel allMoviesModel = AllMoviesModel.fromJson(response.data);
    return allMoviesModel;
  }
}