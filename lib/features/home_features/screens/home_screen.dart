import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/const/theme/colors.dart';
import 'package:onlinemovieplatform/features/details_features/screen/movie_details_screen.dart';
import 'package:onlinemovieplatform/features/home_features/logic/bloc/home_bloc.dart';
import 'package:onlinemovieplatform/features/home_features/logic/cubit/carousel_home_cubit.dart';
import 'package:onlinemovieplatform/features/home_features/model/carousel_model.dart';
import 'package:onlinemovieplatform/features/home_features/model/home_model.dart';
import 'package:onlinemovieplatform/features/home_features/model/movie_slidersection_model.dart';
import 'package:onlinemovieplatform/features/home_features/services/home_repository.dart';
import 'package:onlinemovieplatform/features/movies_features/screens/movie_screen.dart';
import 'package:onlinemovieplatform/features/profile_features/screens/profile_screen.dart';
import 'package:onlinemovieplatform/features/public_features/logic/token_checker/tokencheck_cubit.dart';
import 'package:onlinemovieplatform/features/public_features/widget/error_screen_widet.dart';
import 'package:onlinemovieplatform/features/public_features/widget/search_bar_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../category_features/screen/all_movies_screen.dart';
import '../model/actors_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String screenId = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(HomeRepository())..add(CallHomeEvent()),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primary2Color,
                  ),
                );
              }
              if (state is HomeCompletedState) {
                return RefreshIndicator(
                  color: primary2Color,
                  onRefresh: () async {
                    BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
                  },
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: SearchBarWidget()),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            HomeCarouselSlider(
                              carouselModel: state.carouselModel,
                              urlNavigator: () async {
                                final url = 'https://hosseinkhashaypour.ir';
                                if (await canLaunchUrlString(url)) {
                                  launchUrlString(url);
                                }
                              },
                            ),
                            const SeeAllMoviesSection(),
                            MoviesSectionSlider(
                                movieSlidersectionModel:
                                    state.movieSliderSection),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: Text(
                                    'لیست بازیگران',
                                    style: TextStyle(
                                      fontFamily: 'vazir',
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.keyboard_arrow_left,
                                  ),
                                ),
                              ],
                            ),
                            const ActorsList(),
                            SizedBox(
                              height: 30.sp,
                            ),
                            BlocBuilder<TokencheckCubit, TokencheckState>(
                              builder: (context, state) {
                                if (state is TokenIsLoged) {
                                  return SizedBox.shrink();
                                }
                                if (state is TokenNotLoged) {}
                                return const UserLogin(
                                  buttonText: 'ورود به حساب کاربری',
                                  buttonColor: primary2Color,
                                );
                              },
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            // const UserLogin(
                            //   buttonText: 'خرید اشتراک',
                            //   buttonColor: primary2Color,
                            // ),
                            SizedBox(
                              height: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is HomeErrorState) {
                return ErrorScreenWidget(
                  errorMsg: state.message.errorMsg!,
                  function: () {
                    BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class SeeAllMoviesSection extends StatelessWidget {
  const SeeAllMoviesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailsScreen.screenId);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'مشاهده همه',
                  style: TextStyle(
                    fontFamily: 'vazir',
                    fontSize: 18.sp,
                  ),
                ),
                const SizedBox(width: 8.0), // فاصله بین متن و آیکون
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AllMoviesScreen.screenId,
                    );
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoviesSectionSlider extends StatelessWidget {
  const MoviesSectionSlider({super.key, required this.movieSlidersectionModel});

  final MovieSlidersectionModel movieSlidersectionModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailsScreen.screenId);
      },
      child: Container(
        color: iconColor,
        width: getAllWidth(context),
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieSlidersectionModel.items!.length,
          itemBuilder: (context, index) {
            final helper = movieSlidersectionModel.items![index];
            return ClipRRect(
              borderRadius: getBorderRadiusFunc(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  helper.imageUrl!,
                  fit: BoxFit.cover,
                  width: getWidth(context, 0.5),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeCarouselSlider extends StatelessWidget {
  HomeCarouselSlider({
    super.key,
    required this.carouselModel,
    required this.urlNavigator,
  });

  final CarouselModel carouselModel;
  final PageController _controller = PageController();
  final VoidCallback urlNavigator;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselHomeCubit, int>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => urlNavigator(),
              child: Container(
                width: getAllWidth(context),
                height: 200,
                child: CarouselSlider.builder(
                  // carouselController: _carouselController,
                  itemCount: carouselModel.items!.length,
                  itemBuilder: (context, index, realIndex) {
                    final helper = carouselModel.items![index];
                    return Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: ClipRRect(
                        borderRadius: getBorderRadiusFunc(10),
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/logo.png'),
                          image: NetworkImage(helper.imageUrl!),
                          fit: BoxFit.fill,
                          width: getAllWidth(context),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    // height: getWidth(context, 0.5),
                    // aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      BlocProvider.of<CarouselHomeCubit>(context)
                          .changeCurrentIndex(index);
                    },
                  ),
                ),
              ),
            ),
            // SmoothPageIndicator(
            //   controller: _controller, // PageController
            //   axisDirection: Axis.horizontal,
            //   effect: const ExpandingDotsEffect(
            //     dotWidth: 10,
            //     dotHeight: 10,
            //     spacing: 5,
            //     activeDotColor: primary2Color,
            //   ),
            //   count: 3,
            // ),
          ],
        );
      },
    );
  }
}

class ActorsList extends StatelessWidget {
  const ActorsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: iconColor,
      ),
      width: getAllWidth(context),
      height: getHeight(context, 0.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ActorsModel.actorsModel!.length,
        itemBuilder: (context, index) {
          final actor = ActorsModel.actorsModel[index];
          return Padding(
            padding: EdgeInsets.all(8.sp),
            child: ClipRRect(
              borderRadius: getBorderRadiusFunc(10),
              child: Image.asset(
                actor.image!,
                width: getWidth(context, 0.4),
                height: getHeight(context, 0.4),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserLogin extends StatelessWidget {
  const UserLogin({
    super.key,
    required this.buttonText,
    required this.buttonColor,
  });

  final String buttonText;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            fixedSize: Size(
              getAllWidth(context) - 20,
              getHeight(context, 0.05),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, ProfileScreen.screenId);
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'vazir',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
