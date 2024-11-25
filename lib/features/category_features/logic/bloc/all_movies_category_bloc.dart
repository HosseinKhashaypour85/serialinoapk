import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:onlinemovieplatform/features/category_features/model/all_movies_model.dart';
import 'package:onlinemovieplatform/features/public_features/functions/error/error_message_class.dart';

import '../../../public_features/functions/error/error_exception.dart';
import '../../services/all_movies_api_repository.dart';

part 'all_movies_category_event.dart';
part 'all_movies_category_state.dart';

class AllMoviesCategoryBloc extends Bloc<AllMoviesCategoryEvent, AllMoviesCategoryState> {
  final AllMoviesApiRepository allMoviesApiRepository;
  AllMoviesCategoryBloc(this.allMoviesApiRepository) : super(AllMoviesCategoryInitial()) {
    on<CallAllMoviesCategoryEvent>((event, emit) async{
      emit(AllMoviesCategoryLoadingState());
      try{
        AllMoviesModel allMoviesModel = await allMoviesApiRepository.callAllMoviesApi();
        emit(AllMoviesCategoryCompletedState(allMoviesModel));
      }
          on DioException catch(e){
            emit(AllMoviesCategoryErrorState(
                message:
                ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
          }
    });
  }
}
