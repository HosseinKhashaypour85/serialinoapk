import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/features/home_features/screens/home_screen.dart';
import 'package:onlinemovieplatform/features/intro_features/logic/intro_cubit.dart';
import 'package:onlinemovieplatform/features/public_features/screens/bottom_navigation_bar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/pref/shared_prefences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const String screenId = '/intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pageItem = [
    const PageViewItems(
      image: 'assets/images/intro/movieicon.png',
      title: 'سریالینو !',
      desc: 'تماشای فیلم و سریال بدون هیچ محدودیتی',
    ),
    const PageViewItems(
      image: 'assets/images/intro/download.png',
      title: 'قابلیت دانلود !',
      desc: 'قابلیت دانلود فیلم و سریال بدون هیچ محدودیتی',
    ),
    const PageViewItems(
      image: 'assets/images/intro/time.png',
      title: 'صرفه جویی در وقت!',
      desc: 'فیلم و سریال هاتو بدون تبلیغ تماشا کن !',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final introCubit = BlocProvider.of<IntroCubit>(context);
    return Scaffold(
      body: BlocBuilder<IntroCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 150,
                  color: Colors.deepPurple,
                  child: Center(
                    child: Container(
                      height: 200,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 400,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: pageItem.length,
                        itemBuilder: (context, index) {
                          return pageItem[index];
                        },
                        onPageChanged: (value) {
                          BlocProvider.of<IntroCubit>(context)
                              .changeIndex(value);
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: pageItem.length,
                      axisDirection: Axis.horizontal,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 5,
                        activeDotColor: primary2Color,
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(getWidth(context, 0.7), 50),
                        backgroundColor: primary2Color,
                      ),
                      onPressed: () {
                        if (introCubit.currentIndex < 2) {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        } else {
                          SharedPref().setIntroStatus();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            BottomNavigationBarScreen.screenId,
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        introCubit.currentIndex < 2 ? 'بعدی' : 'بزن بریم',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "vazir",
                        ),
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

class PageViewItems extends StatelessWidget {
  const PageViewItems({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  final String? image;
  final String? title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          Image.asset(
            image!,
            width: 80.sp,
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            title!,
            style: TextStyle(
              fontFamily: 'vazir',
              decoration: TextDecoration.none,
              fontSize: 23.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          RichText(
            text: TextSpan(
              text: desc,
              style: TextStyle(
                fontFamily: 'vazir',
                decoration: TextDecoration.none,
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
