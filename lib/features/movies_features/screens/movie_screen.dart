import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/const/theme/colors.dart';
import 'package:onlinemovieplatform/features/movies_features/logic/movie_bloc.dart';
import 'package:onlinemovieplatform/features/movies_features/services/movie_api_repository.dart';
import 'package:onlinemovieplatform/features/public_features/functions/movie_id_checker/movie_id_checker_func.dart';

import '../model/movie_model.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  static const String screenId = 'movie_screen';

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var movieId = arguments['movieId'];
    // print(movieId);

    return BlocProvider(
      create: (context) => MovieBloc(
        MovieApiRepository(),
      )..add(
          CallMovieEvent(
            movieId: movieId,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primary2Color,
                ),
              );
            }
            if (state is MovieCompletedState) {
              return MovieDetails(
                movieModel: state.movieModel,

              );
            }
            if (state is MovieErrorState) {}
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    super.key,
    required this.movieModel,
  });

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      child: ListView.builder(
        itemCount: movieModel.items!.length,
        itemBuilder: (context, index) {
          final helper = movieModel.items![index];
          return Column(
            children: [
              Positioned(
                top: 0,
                child: ClipRRect(
                  borderRadius: getBorderRadiusFunc(10),
                  child: Image.network(
                    helper.imageUrl!,
                    width: getAllWidth(context) - getWidth(context, 0.1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    Text(
                      'نام فیلم :',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      helper.title!,
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      'دسته بندی :',
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      setCategoryById(
                        helper.category!,
                      ),
                      style: TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
