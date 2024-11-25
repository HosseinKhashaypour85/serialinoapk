import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onlinemovieplatform/const/shape/border_radius.dart';
import 'package:onlinemovieplatform/const/shape/media_query.dart';
import 'package:onlinemovieplatform/const/theme/colors.dart';
import 'package:onlinemovieplatform/features/public_features/functions/secure_storage/secure_storage_class.dart';
import 'package:onlinemovieplatform/features/public_features/screens/bottom_navigation_bar_screen.dart';
import 'package:onlinemovieplatform/features/public_features/widget/snack_bar_widget.dart';

import '../widget/text_form_field_multi_line.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  static const String screenId = '/comment_screen';

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(
              10.sp,
            ),
            child: Container(
              height: getHeight(context, 0.3),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: getBorderRadiusFunc(10),
              ),
              child: TextFormFieldMultiLine(
                minLine: 1,
                maxLine: 10,
                labelText: 'دیدگاه شما',
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.multiline,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                controller: _commentController,
                icon: Icon(
                  Icons.comment,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(
                getWidth(context, 0.4),
                50,
              ),
              backgroundColor: primary2Color,
            ),
            onPressed: () {
              getSnackBarWidget(
                  context, 'دیدگاه شما با موفقیت ذخیره شد !', Colors.green);
              Navigator.pushNamed(
                  context, BottomNavigationBarScreen.screenId);
            },
            child: Text(
              'ثبت دیدگاه',
              style: TextStyle(
                fontFamily: 'vazir',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
