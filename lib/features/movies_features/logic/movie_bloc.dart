import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:onlinemovieplatform/features/movies_features/model/movie_model.dart';
import 'package:onlinemovieplatform/features/movies_features/services/movie_api_repository.dart';
import 'package:onlinemovieplatform/features/public_features/functions/error/error_message_class.dart';

import '../../public_features/functions/error/error_exception.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApiRepository movieApiRepository;

  MovieBloc(this.movieApiRepository) : super(MovieInitial()) {
    on<CallMovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {
        MovieModel movieModel = await movieApiRepository.callAllMoviesApi(event.movieId);
        emit(MovieCompletedState(movieModel: movieModel));
      } on DioException catch (e) {
        emit(
          MovieErrorState(
            message: ErrorMessageClass(
              errorMsg: ErrorExceptions().fromError(e),
            ),
          ),
        );
      }
    });
  }
}
