part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieCompletedState extends MovieState {
  final MovieModel movieModel;
  MovieCompletedState({required this.movieModel});
}

class MovieErrorState extends MovieState {
  final ErrorMessageClass message;
  MovieErrorState({required this.message});
}
