import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:onlinemovieplatform/features/home_features/model/carousel_model.dart';
import 'package:onlinemovieplatform/features/home_features/model/movie_slidersection_model.dart';
import 'package:onlinemovieplatform/features/home_features/services/home_repository.dart';
import 'package:onlinemovieplatform/features/public_features/functions/error/error_message_class.dart';

import '../../../public_features/functions/error/error_exception.dart';
import '../../model/home_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<CallHomeEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        CarouselModel carouselModel = await repository.callCarouselApi();
        HomeModel homeModel = await repository.callHomeApi();
        MovieSlidersectionModel movieSlidersectionModel = await repository.callMovieSliderSectionApi();
        emit(HomeCompletedState(carouselModel: carouselModel, homeModel: homeModel , movieSliderSection:  movieSlidersectionModel));
      } on DioException catch (e) {
        emit(HomeErrorState(
            message:
                ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
      }
    });
    on<CallMovieSectionBarEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        HomeModel homeModel = await repository.callHomeApi();
        CarouselModel carouselModel = await repository.callCarouselApi();
        MovieSlidersectionModel movieSlidersectionModel = await repository.callMovieSliderSectionApi();
        emit(HomeCompletedState(homeModel: homeModel, carouselModel: carouselModel , movieSliderSection: movieSlidersectionModel));
      } on DioException catch (e) {
        emit(HomeErrorState(
            message:
                ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
      }
    });
  }
}
