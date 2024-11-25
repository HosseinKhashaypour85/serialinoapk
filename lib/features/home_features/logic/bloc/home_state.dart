part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoadingState extends HomeState {
}

class HomeCompletedState extends HomeState {
  final dynamic carouselModel;
  final dynamic homeModel;
  final dynamic movieSliderSection;
  HomeCompletedState({required this.carouselModel , required this.homeModel , required this.movieSliderSection});
}
class HomeErrorState extends HomeState {
  final ErrorMessageClass message;
  HomeErrorState({required this.message});
}
