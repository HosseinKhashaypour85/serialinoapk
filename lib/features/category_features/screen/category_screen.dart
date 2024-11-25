import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/const/theme/colors.dart';
import 'package:onlinemovieplatform/features/category_features/screen/all_movies_screen.dart';
import 'package:onlinemovieplatform/features/details_features/screen/movie_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const String screenId = '/category_screen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // دریافت آرگومان‌های ارسال شده
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            20.sp,
          ),
          child: Center(
            child: Column(
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    CategoryWidget(
                      icon: FontAwesomeIcons.gun,
                      title: 'اکشن',
                      navigator: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.screenId,
                          arguments: {'categoryId': 'pjpwnhf2fow9whr'},
                        );
                      },
                    ),
                    CategoryWidget(
                      icon: FontAwesomeIcons.faceLaugh,
                      title: 'کمدی',
                      navigator: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.screenId,
                          arguments: {'categoryId': '8zhsvx084dbntif'},
                        );
                      },
                    ),
                    CategoryWidget(
                      icon: FontAwesomeIcons.clockRotateLeft,
                      title: 'تاریخی',
                      navigator: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.screenId,
                          arguments: {'categoryId': '8s68zddh01rtfa9'},
                        );
                      },
                    ),
                    CategoryWidget(
                      icon: Icons.music_note,
                      title: 'موسیقی',
                      navigator: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.screenId,
                          arguments: {'categoryId': '4enex4wbs2qjef8'},
                        );
                      },
                    ),
                    CategoryWidget(
                      icon: Icons.fitness_center,
                      title: 'ورزشی',
                      navigator: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.screenId,
                          arguments: {'categoryId': '6gqp5r2gzhno1i6'},
                        );
                      },
                    ),
                    CategoryWidget(
                      icon: Icons.science,
                      title: 'علمی',
                      navigator: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.screenId,
                          arguments: {'categoryId': 'krd4afqa3ca3tkb'},
                        );
                      },
                    ),
                    CategoryWidget(
                      icon: Icons.all_inbox,
                      title: 'همه',
                      navigator: () {
                        Navigator.pushNamed(
                          context,
                          AllMoviesScreen.screenId,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.navigator,
  });

  final IconData icon;
  final String title;
  final VoidCallback navigator;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigator,
      child: Container(
        width: getWidth(context, 0.27),
        height: getHeight(context, 0.11),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: getBorderRadiusFunc(10),
        ),
        padding: EdgeInsets.all(15.sp),
        child: Column(
          children: [
            Icon(
              icon,
              color: primary2Color,
              size: 20.sp,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'vazir',
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
