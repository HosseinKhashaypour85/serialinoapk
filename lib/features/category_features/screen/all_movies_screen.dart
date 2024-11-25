import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/const/theme/colors.dart';
import 'package:onlinemovieplatform/features/category_features/logic/bloc/all_movies_category_bloc.dart';
import 'package:onlinemovieplatform/features/category_features/model/all_movies_model.dart';
import 'package:onlinemovieplatform/features/category_features/services/all_movies_api_repository.dart';
import 'package:onlinemovieplatform/features/movies_features/screens/movie_screen.dart';

class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({super.key});

  static const String screenId = 'all_movies_screen';

  @override
  State<AllMoviesScreen> createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllMoviesCategoryBloc(
        AllMoviesApiRepository(),
      )..add(
          CallAllMoviesCategoryEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<AllMoviesCategoryBloc, AllMoviesCategoryState>(
          builder: (context, state) {
            if (state is AllMoviesCategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primary2Color,
                ),
              );
            }
            if (state is AllMoviesCategoryCompletedState) {
              return AllMoviesWidget(
                allMoviesModel: state.allMoviesModel,
                navigator: (String movieId) {
                  Navigator.pushNamed(
                    context,
                    MovieScreen.screenId,
                    arguments: {
                      'movieId': movieId,
                    },
                  );
                },
              );
            }
            if (state is AllMoviesCategoryErrorState) {}
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class AllMoviesWidget extends StatelessWidget {
  const AllMoviesWidget({
    super.key,
    required this.allMoviesModel,
    this.navigator,
  });

  final AllMoviesModel allMoviesModel;
  final Function(String)? navigator;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: allMoviesModel.items!.length,
        itemBuilder: (context, index) {
          final helper = allMoviesModel.items![index];
          return InkWell(
            onTap: (){
              navigator!(helper.id!.toString());
            },
            child: Image.network(
              helper.imageUrl!,
              fit: BoxFit.cover,
              width: getAllWidth(context),
            ),
          );
        },
      ),
    );
  }
}
