import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinemovieplatform/features/auth_features/screen/auth_screen.dart';
import 'package:onlinemovieplatform/features/profile_features/screens/profile_screen.dart';
import 'package:onlinemovieplatform/features/public_features/logic/token_checker/tokencheck_cubit.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});
  static const String screenId = '/authcheck_screen';

  @override
  State<AuthCheck> createState() => _AuthtokenCheckerState();
}

class _AuthtokenCheckerState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokencheckCubit, TokencheckState>(
        builder: (context, state) {
          if (state is TokenIsLoged) {
            return ProfileScreen();
          } else {
            return AuthScreen();
          }
        },
      );
  }
}
