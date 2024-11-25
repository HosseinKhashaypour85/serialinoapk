import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_home_state.dart';

class CarouselHomeCubit extends Cubit<int> {
  CarouselHomeCubit() : super(0);

  int currentIndex = 0;
  changeCurrentIndex(int index){
    emit(currentIndex = index);
  }
}
