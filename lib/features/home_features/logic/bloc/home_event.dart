part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}
class CallHomeEvent extends HomeEvent{}
class CallMovieSectionBarEvent extends HomeEvent{}
class CallMovieSliderSection extends HomeEvent{}