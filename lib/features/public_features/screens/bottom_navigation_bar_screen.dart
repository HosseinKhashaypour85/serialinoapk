import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemovieplatform/const/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:onlinemovieplatform/features/auth_features/logic/auth_bloc.dart';
import 'package:onlinemovieplatform/features/auth_features/screen/auth_screen.dart';
import 'package:onlinemovieplatform/features/category_features/screen/category_screen.dart';
import 'package:onlinemovieplatform/features/home_features/screens/home_screen.dart';
import 'package:onlinemovieplatform/features/profile_features/screens/authtoken_checker_screen.dart';
import 'package:onlinemovieplatform/features/profile_features/screens/profile_screen.dart';
import 'package:onlinemovieplatform/features/public_features/logic/bottomNav/bottomnav_cubit.dart';
import 'package:onlinemovieplatform/features/public_features/logic/token_checker/tokencheck_cubit.dart';
import 'package:onlinemovieplatform/features/search_features/screens/search_screen.dart';

import '../../favorite_features/screens/favorite_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  static const String screenId = '/bottom_nav_bar_screen';

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();

}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List<Widget> screenList = [
    const HomeScreen(),
    SearchScreen(),
    const CategoryScreen(),
    const AuthCheck(),
  ];
@override
  void initState() {
    super.initState();
    BlocProvider.of<TokencheckCubit>(context).tokenChecker();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavCubit = BlocProvider.of<BottomnavCubit>(context);
    return BlocBuilder<BottomnavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
              fontFamily: 'vazir',
            ),
            unselectedItemColor: theme.iconTheme.color,
            selectedLabelStyle: TextStyle(
              fontFamily: 'vazir',
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            selectedItemColor: primary2Color,
            items: const [
              BottomNavigationBarItem(
                label: 'خانه',
                icon: Icon(
                  Icons.home_outlined,
                ),
                activeIcon: Icon(
                  Icons.home,
                ),
              ),
              BottomNavigationBarItem(
                label: 'جستجو',
                icon: Icon(
                  Icons.search_outlined,
                ),
                activeIcon: Icon(
                  Icons.search,
                ),
              ),
              BottomNavigationBarItem(
                label: 'دسته بندی ها',
                icon: Icon(
                  Icons.category_outlined,
                ),
                activeIcon: Icon(
                  Icons.category,
                ),
              ),
              BottomNavigationBarItem(
                label: 'پروفایل',
                icon: Icon(
                  Icons.person_outline,
                ),
                activeIcon: Icon(
                  Icons.person,
                ),
              ),
            ],
            currentIndex: bottomNavCubit.screenIndex,
            onTap: (value) {
              bottomNavCubit.onTap(value);
            },
          ),
          body: screenList.elementAt(bottomNavCubit.screenIndex),
        );
      },
    );
  }
}
