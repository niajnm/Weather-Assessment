import 'package:flutter/material.dart';
import 'package:flutter_craft/app/core/values/app_values.dart';
import 'package:flutter_craft/app/core/values/style_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxTile extends StatelessWidget {
  final icon;
  final firstTitle;
  final secondTitle;
  final firstDesc;
  final secondDesc;
  final time;

  const BoxTile(
      {super.key,
      this.icon,
      this.time,
      this.firstTitle,
      this.secondTitle,
      this.firstDesc,
      this.secondDesc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, AppValues.basePadding, 40, 0),
      child: Container(
        decoration: glassBoxDecorationStyle,
        height: 90.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.sunny_snowing,
                  size: 50,
                ),
                _infoColumn(firstTitle, firstDesc),
                _infoColumn(secondTitle, secondDesc)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(title, desc) => Column(
        children: [Text(title ?? ''), Text(desc ?? '')],
      );
}
