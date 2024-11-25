part of 'all_movies_category_bloc.dart';

@immutable
abstract class AllMoviesCategoryState {}

class AllMoviesCategoryInitial extends AllMoviesCategoryState {}

class AllMoviesCategoryLoadingState extends AllMoviesCategoryState {}

class AllMoviesCategoryCompletedState extends AllMoviesCategoryState {
  final AllMoviesModel allMoviesModel;
  AllMoviesCategoryCompletedState(this.allMoviesModel);
}

class AllMoviesCategoryErrorState extends AllMoviesCategoryState {
  final ErrorMessageClass message;
  AllMoviesCategoryErrorState({required this.message});
}

