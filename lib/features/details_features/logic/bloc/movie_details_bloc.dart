import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:onlinemovieplatform/features/details_features/services/details_repository_services.dart';

import '../../../public_features/functions/error/error_exception.dart';
import '../../../public_features/functions/error/error_message_class.dart';
import '../../model/details_model.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  DetailsRepositoryServices detailsRepositoryServices = DetailsRepositoryServices();
  MovieDetailsBloc(this.detailsRepositoryServices) : super(MovieDetailsInitial()) {
    on<CallMovieDetailsEvent>((event, emit) async{
      emit(MovieDetailsLoadingState());
      try{
        DetailsModel detailsModel = await detailsRepositoryServices.callDetailsApi(event.categoryId);
        emit(MovieDetailsCompletedState(detailsModel));
      }
          on DioException catch(e){
            emit(MovieDetailsErrorState(
                message:
                ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
          }

    });
  }
}
