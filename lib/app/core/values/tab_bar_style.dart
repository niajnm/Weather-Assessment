import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'text_style.dart';

final TabBarTheme lightTabBarTheme = TabBarTheme(
    labelColor: AppColors.blueWarningPrimaryColor,
    unselectedLabelColor: AppColors.neutral500,
    unselectedLabelStyle: headlineSmallTextStyle,
    labelStyle: headlineSmallTextStyle,
    indicator: tabBarIndicatorStyle);

final TabBarTheme darkTabBarTheme = TabBarTheme(
    labelColor: AppColors.almostBlack,
    unselectedLabelColor: AppColors.blueWarningPrimaryColor,
    unselectedLabelStyle: headlineSmallTextStyle,
    labelStyle: headlineSmallTextStyle,
    indicator: tabBarIndicatorStyle);

Decoration get tabBarIndicatorStyle => BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
        ),
      ],
      border: Border.all(
        color: AppColors.neutral100,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white,
    );

Decoration get tabBarBoxDecorationStyle => BoxDecoration(
      color: AppColors.neutral100,
      borderRadius: BorderRadius.circular(7.0),
    );
