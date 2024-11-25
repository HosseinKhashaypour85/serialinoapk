import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:onlinemovieplatform/features/intro_features/screens/intro_screen.dart';
import 'package:onlinemovieplatform/features/public_features/functions/pref/shared_prefences.dart';
import 'package:onlinemovieplatform/features/public_features/screens/bottom_navigation_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String screenId = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() {
    Timer(
      Duration(seconds: 3),
      () async {
        if (await SharedPref().getIntroStatus()) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavigationBarScreen.screenId,
            (route) => false,
          );
        } else{
          Navigator.pushReplacementNamed(context, IntroScreen.screenId);
        }
      },
    );
  }
@override
  void initState() {
    super.initState();
    navigate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeInUp(
            child: Image.asset(
              'assets/images/logo.png',
            ),
          )
        ],
      ),
    );
  }
}
