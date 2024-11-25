import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/features/details_features/logic/bloc/movie_details_bloc.dart';
import 'package:onlinemovieplatform/features/details_features/model/details_model.dart';
import 'package:onlinemovieplatform/features/details_features/services/details_repository_services.dart';
import 'package:onlinemovieplatform/features/public_features/widget/error_screen_widet.dart';

import '../../../const/theme/colors.dart';
import '../../movies_features/screens/movie_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({
    super.key,
  });

  static const String screenId = '/details_screen';

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var categoryId = arguments['categoryId'];
    var movieId = arguments['movieId'];

    return BlocProvider(
      create: (context) => MovieDetailsBloc(
        DetailsRepositoryServices(),
      )..add(CallMovieDetailsEvent(categoryId)),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primary2Color,
                ),
              );
            }
            if (state is MovieDetailsCompletedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<MovieDetailsBloc>(context)
                      .add(CallMovieDetailsEvent(categoryId));
                },
                child: MoviesDetailsList(
                  detailsModel: state.detailsModel,
                  navigator: (String movieId) {
                    Navigator.pushNamed(
                      context,
                      MovieScreen.screenId,
                      arguments: {
                        'movieId': movieId,
                      },
                    );
                  },
                ),
              );
            }
            if (state is MovieDetailsErrorState) {
              return ErrorScreenWidget(
                errorMsg: state.message.errorMsg!,
                function: () {
                  BlocProvider.of<MovieDetailsBloc>(context)
                      .add(CallMovieDetailsEvent(categoryId));
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class MoviesDetailsList extends StatelessWidget {
  const MoviesDetailsList({
    super.key,
    required this.detailsModel,
    required this.navigator,
  });

  final DetailsModel detailsModel;
  final Function(String) navigator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      height: getAllHeight(context),
      padding: EdgeInsets.all(8.sp),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: detailsModel.items!.length,
        itemBuilder: (context, index) {
          final helper = detailsModel.items![index];
          return InkWell(
            onTap: () {
              navigator(helper.id.toString());
            },
            child: Card(
              child: ListTile(
                title: Text(helper.title!),
                leading: ClipRRect(
                  borderRadius: getBorderRadiusFunc(10),
                  child: Image.network(
                    helper.imageUrl!,
                    width: getWidth(context, 0.2),
                    height: getHeight(context, 0.4),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
