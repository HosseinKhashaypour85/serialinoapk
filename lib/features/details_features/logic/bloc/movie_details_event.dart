part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsEvent {}

class CallMovieDetailsEvent extends MovieDetailsEvent {
  final String categoryId;
  CallMovieDetailsEvent(this.categoryId);
}
