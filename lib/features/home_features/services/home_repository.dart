import 'package:dio/dio.dart';
import 'package:onlinemovieplatform/features/home_features/model/carousel_model.dart';
import 'package:onlinemovieplatform/features/home_features/model/home_model.dart';
import 'package:onlinemovieplatform/features/home_features/model/movie_slidersection_model.dart';
import 'package:onlinemovieplatform/features/home_features/screens/home_screen.dart';
import 'package:onlinemovieplatform/features/home_features/services/home_api_services.dart';

class HomeRepository {
  final HomeApiServices _apiServices = HomeApiServices();

  Future<HomeModel> callHomeApi() async {
    final Response response = await _apiServices.callHomeApi();
    HomeModel homeModel = HomeModel.fromJson(response.data);
    return homeModel;
  }

//   carousel sliders api repository
  Future<CarouselModel> callCarouselApi() async {
    final Response response = await _apiServices.callCarouselApi();
    CarouselModel carouselModel = CarouselModel.fromJson(response.data);
    return carouselModel;
  }
  // movie slider section api repository
  Future<MovieSlidersectionModel> callMovieSliderSectionApi()async{
    final Response response = await _apiServices.callMovieSliderSectionApi();
    MovieSlidersectionModel movieSlidersectionModel = MovieSlidersectionModel.fromJson(response.data);
    return movieSlidersectionModel;
  }
}
