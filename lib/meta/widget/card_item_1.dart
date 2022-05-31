import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:why_not_143_team/meta/helper/constant/color_constant.dart';
import 'package:why_not_143_team/meta/helper/constant/padding_constant.dart';
import 'package:why_not_143_team/meta/helper/constant/text_style.dart';

class CardItem extends StatelessWidget {
  final String text;
  final String buttonText;
  final String pageRoute;
  const CardItem({required this.text, required this.buttonText,required this.pageRoute, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.3, 1],
            colors: [ColorConstant.instance.yankeBlue, Colors.blueGrey]),
      ),
      child: Padding(
        padding: PaddingConstant.instance.genelButtonPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text,
                style: TextStyleConstant.instance.textLargeMedium
                    .copyWith(color: ColorConstant.instance.white)),
            Row(
              children: [
                SizedBox(
                  width: 100.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, pageRoute);
                    },
                    child: Text(buttonText),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      primary: ColorConstant.instance.white,
                      onPrimary: ColorConstant.instance.yankeBlue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
