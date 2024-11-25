import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/const/theme/colors.dart';
import 'package:onlinemovieplatform/features/comment_features/screen/comment_screen.dart';
import 'package:onlinemovieplatform/features/public_features/widget/snack_bar_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../subscription_features/model/subscription_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String screenId = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSubscribed = false;
  late SubscriptionModel _userSubscription;

  @override
  void initState() {
    super.initState();
    _loadSubStatus();
  }

  // بارگذاری وضعیت اشتراک
  void _loadSubStatus() async {
    final box = await Hive.openBox<SubscriptionModel>('subscriptionBox');
    final subscription = box.get('userSubscription');

    if (subscription != null) {
      final expirationDate =
          subscription.expirationDate; // مستقیم استفاده از DateTime
      setState(() {
        _isSubscribed = expirationDate.isAfter(DateTime.now());
        _userSubscription = subscription; // ذخیره وضعیت اشتراک
      });
    }
  }

  // ذخیره وضعیت اشتراک
  void saveSubscription(bool isSubscribed, DateTime expirationDate) async {
    final box = await Hive.openBox<SubscriptionModel>('subscriptionBox');
    final subscription = SubscriptionModel(
      isSubscribed: isSubscribed,
      expirationDate: expirationDate, // ذخیره مستقیم DateTime
    );
    await box.put('userSubscription', subscription);
    setState(() {
      _isSubscribed = isSubscribed;
      _userSubscription = subscription;
    });
  }

  // نمایش BottomSheet برای خرید اشتراک
  void showBottomSheetFunc(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: getAllWidth(context),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                Text(
                  'اشتراک ندارید!',
                  style: TextStyle(
                    fontFamily: 'vazir',
                    color: Colors.red,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Text(
                  'شما درحال حاضر اشتراکی ندارید! قصد خرید اشتراک دارید؟',
                  style: TextStyle(
                    fontFamily: 'vazir',
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            getWidth(context, 0.4),
                            50,
                          ),
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        saveSubscription(
                          true,
                          DateTime.now().add(Duration(days: 30)),
                        );
                        getSnackBarWidget(context,
                            'اشتراک شما به مدت 30 روز شارژ شد', Colors.green);
                        Navigator.pop(context); // بستن BottomSheet
                      },
                      child: Text(
                        'خرید اشتراک',
                        style: TextStyle(
                          fontFamily: 'vazir',
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          getWidth(context, 0.4),
                          50,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'بازگشت',
                        style: TextStyle(
                          fontFamily: 'vazir',
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.sp,
            ),
            SafeArea(
              child: CircleAvatar(
                radius: getWidth(context, 0.1),
                child: Icon(
                  Icons.person,
                  size: 25.sp,
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Text(
              'کاربر گرامی',
              style: TextStyle(
                fontFamily: 'vazir',
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 30.sp,
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: getBorderRadiusFunc(10),
                ),
                child: ListTile(
                  title: Text(
                    'وضعیت اشتراک',
                    style: TextStyle(
                      fontFamily: 'vazir',
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  leading: const Icon(
                    Icons.subscriptions,
                    color: Colors.black,
                  ),
                  onTap: () {
                    if (!_isSubscribed) {
                      showBottomSheetFunc(context);
                    } else {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: getAllWidth(context),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30.sp,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: getBorderRadiusFunc(100),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 40.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.sp,
                                ),
                                Text(
                                  'اکانت شما دارای اشتراک هست',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'vazir',
                                  ),
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                Text(
                                  'از شما بابت خریدتان سپاسگذاریم',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'vazir',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: getBorderRadiusFunc(10),
                ),
                child: ListTile(
                  title: Text(
                    'درباره ما',
                    style: TextStyle(
                      fontFamily: 'vazir',
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.people,
                    color: Colors.black,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        final textHelper =
                            'حسین خشای پور هستم، برنامه‌نویس با تجربه در زمینه‌ی فلاتر و توسعه‌ی اپلیکیشن‌های موبایل. با طراحی و توسعه‌ی پروژه‌های متنوع و قابل‌قبول، توانسته‌ام توانایی‌های خود را در این حوزه به خوبی به نمایش بگذارم. علاوه بر این، در زمینه‌ی توسعه‌ی وب نیز فعالیت دارم و با تکنولوژی‌های سی اس اس و جاوا اسکریپت آشنایی دارم. همچنین، تجربه‌ی کار با ری اکت را نیز دارم و در حال بهبود مهارت‌هایم در این حوزه هستم. هدف من، خلق نرم‌افزارهایی با کیفیت و کاربردی است که بتوانند تجربه‌ی بهتری را برای کاربران فراهم کند';
                        return Container(
                          padding: EdgeInsets.all(8.sp),
                          width: getAllWidth(context),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                textHelper,
                                style: TextStyle(
                                  fontFamily: 'vazir',
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(
                                height: 30.sp,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'سایت من : ',
                                    style: TextStyle(
                                      fontFamily: 'vazir',
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final url =
                                          'https://hosseinkhashaypour.ir/';
                                      if (await canLaunchUrlString(url!)) {
                                        launchUrlString(url);
                                      }
                                    },
                                    child: Text(
                                      'hosseinkhashaypour.ir',
                                      style: TextStyle(
                                        fontFamily: 'vazir',
                                        fontSize: 20.sp,
                                        color: primary2Color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'شماره تماس من :',
                                    style: TextStyle(
                                      fontFamily: 'vazir',
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final url = 'tel:+989120776658';
                                      if (await canLaunchUrlString(url!)) {
                                        launchUrlString(url);
                                      }
                                    },
                                    child: Text(
                                      '09120776658',
                                      style: TextStyle(
                                        fontFamily: 'vazir',
                                        fontSize: 20.sp,
                                        color: primary2Color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary2Color),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'بازگشت',
                                  style: TextStyle(
                                    fontFamily: 'vazir',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: getBorderRadiusFunc(10),
                ),
                child: ListTile(
                  title: Text(
                    'ثبت نظر',
                    style: TextStyle(
                      fontFamily: 'vazir',
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.comment,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, CommentScreen.screenId);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
