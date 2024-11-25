import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:onlinemovieplatform/features/auth_features/services/auth_repository_services.dart';
import 'package:onlinemovieplatform/features/public_features/functions/error/error_message_class.dart';

import '../../public_features/functions/error/error_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryServices authRepositoryServices;
  AuthBloc(this.authRepositoryServices) : super(AuthInitial()) {
    on<CallAuthEvent>((event, emit) async{
      emit(AuthLoadingState());
      try{
        final String? token = await authRepositoryServices.callAuthApi(event.phoneNumber!);
        emit(AuthCompletedState(token!));
      }
          on DioException catch(e){
            AuthErrorState(error: ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e)));
          }
    });
  }
}
