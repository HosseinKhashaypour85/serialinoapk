part of 'tokencheck_cubit.dart';

@immutable
abstract class TokencheckState {}

class TokencheckInitial extends TokencheckState {}
class TokenIsLoged extends TokencheckState {}
class TokenNotLoged extends TokencheckState {}
