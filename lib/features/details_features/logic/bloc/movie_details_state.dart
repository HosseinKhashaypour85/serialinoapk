part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsState {}
class MovieDetailsInitial extends MovieDetailsState {}
class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsCompletedState extends MovieDetailsState {
  final DetailsModel detailsModel;
  MovieDetailsCompletedState(this.detailsModel);
}

class MovieDetailsErrorState extends MovieDetailsState {
  final ErrorMessageClass message;
  MovieDetailsErrorState({required this.message});
}
