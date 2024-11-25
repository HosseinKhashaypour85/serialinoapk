import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:onlinemovieplatform/features/auth_features/logic/auth_bloc.dart';
import 'package:onlinemovieplatform/features/auth_features/services/auth_repository_services.dart';
import 'package:onlinemovieplatform/features/category_features/logic/bloc/all_movies_category_bloc.dart';
import 'package:onlinemovieplatform/features/category_features/screen/category_screen.dart';
import 'package:onlinemovieplatform/features/details_features/logic/bloc/movie_details_bloc.dart';
import 'package:onlinemovieplatform/features/details_features/screen/movie_details_screen.dart';
import 'package:onlinemovieplatform/features/details_features/services/details_repository_services.dart';
import 'package:onlinemovieplatform/features/favorite_features/screens/favorite_screen.dart';
import 'package:onlinemovieplatform/features/home_features/logic/bloc/home_bloc.dart';
import 'package:onlinemovieplatform/features/home_features/logic/cubit/carousel_home_cubit.dart';
import 'package:onlinemovieplatform/features/home_features/services/home_repository.dart';
import 'package:onlinemovieplatform/features/intro_features/logic/intro_cubit.dart';
import 'package:onlinemovieplatform/features/intro_features/screens/intro_screen.dart';
import 'package:onlinemovieplatform/features/profile_features/screens/profile_screen.dart';
import 'package:onlinemovieplatform/features/public_features/logic/token_checker/tokencheck_cubit.dart';
import 'package:onlinemovieplatform/features/public_features/screens/bottom_navigation_bar_screen.dart';
import 'features/auth_features/screen/auth_screen.dart';
import 'features/category_features/screen/all_movies_screen.dart';
import 'features/category_features/services/all_movies_api_repository.dart';
import 'features/comment_features/screen/comment_screen.dart';
import 'features/favorite_features/model/favorite_model.dart';
import 'features/intro_features/screens/splash_screen.dart';
import 'features/movies_features/screens/movie_screen.dart';
import 'features/profile_features/screens/authtoken_checker_screen.dart';
import 'features/profile_features/screens/profile_screen.dart';
import 'features/public_features/logic/bottomNav/bottomnav_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/public_features/screens/bottom_navigation_bar_screen.dart';
import 'features/search_features/screens/search_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/subscription_features/model/subscription_model.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.registerAdapter(MovieAdapter());
  await Hive.openBox('FavMovieName');
  Hive.registerAdapter(SubscriptionModelAdapter());
  await Hive.openBox<SubscriptionModel>('subscriptionBox');
  // await Hive.openBox('userPhoneNum');
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => BottomnavCubit()),
            BlocProvider(create: (context) => IntroCubit()),
            BlocProvider(create: (context) => HomeBloc(HomeRepository())),
            BlocProvider(
              create: (context) => CarouselHomeCubit(),
            ),
            BlocProvider(
              create: (context) => AuthBloc(AuthRepositoryServices()),
            ),
            BlocProvider(
              create: (context) => TokencheckCubit(),
            ),
            BlocProvider(
              create: (context) => MovieDetailsBloc(
                DetailsRepositoryServices(),
              ),
            ),
            BlocProvider(
              create: (context) => AllMoviesCategoryBloc(
                AllMoviesApiRepository(),
              ),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('fa'),
            ],
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.screenId,
            routes: {
              BottomNavigationBarScreen.screenId: (context) =>
                  const BottomNavigationBarScreen(),
              IntroScreen.screenId: (context) => const IntroScreen(),
              SplashScreen.screenId: (context) => const SplashScreen(),
              SearchScreen.screenId: (context) => SearchScreen(),
              MovieDetailsScreen.screenId: (context) =>
                  const MovieDetailsScreen(),
              ProfileScreen.screenId: (context) => const ProfileScreen(),
              AuthScreen.screenId: (context) => const AuthScreen(),
              AuthCheck.screenId: (context) => const AuthCheck(),
              FavoriteScreen.screenId: (context) => const FavoriteScreen(),
              CommentScreen.screenId: (context) => const CommentScreen(),
              CategoryScreen.screenId: (context) => const CategoryScreen(),
              MovieScreen.screenId : (context) => const MovieScreen(),
              AllMoviesScreen.screenId : (context) => const AllMoviesScreen(),
            },
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
