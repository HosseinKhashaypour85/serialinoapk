part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class CallMovieEvent extends MovieEvent {
  final String movieId;
  CallMovieEvent({required this.movieId});
}
