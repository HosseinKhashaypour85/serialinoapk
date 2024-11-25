import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onlinemovieplatform/features/public_features/functions/secure_storage/secure_storage_class.dart';

part 'tokencheck_state.dart';

class TokencheckCubit extends Cubit<TokencheckState> {
  TokencheckCubit() : super(TokencheckInitial());

  tokenChecker()async{
    final status = await SecureStorageClass().getUserToken();
    if(status != null){
      emit(TokenIsLoged());
    } else{
      emit(TokenNotLoged());
    }
  }
}
