import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

abstract class AppGradients {
  static const LinearGradient horizontalCalendarGradient =  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.primaryGreen02, AppColors.primaryGreen03],
  );
  static const LinearGradient datePickerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.primaryGreen04, AppColors.primaryGreen03],
  );
}