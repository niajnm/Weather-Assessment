import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_craft/app/core/values/app_colors.dart';
import 'package:flutter_craft/app/core/values/app_fonts.dart';
import 'package:flutter_craft/app/core/values/app_language.dart';
import 'package:flutter_craft/app/core/values/app_values.dart';
import 'package:flutter_craft/app/core/values/style_sheet.dart';
import 'package:flutter_craft/app/core/values/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static ThemeData getDarkTheme(String appLanguage) {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      primaryColor: AppColors.colorPrimary,
      buttonTheme: const ButtonThemeData(alignedDropdown: true),
      cardColor: AppColors.primaryGreen05,
      iconTheme: const IconThemeData(color: AppColors.colorWhite),
      indicatorColor: AppColors.colorWhite,
      dividerColor: AppColors.neutralGray,
      hintColor: AppColors.neutralLightGray,
      dialogBackgroundColor: AppColors.pageBackgroundDark,
      tabBarTheme: darkTabBarTheme,
      textTheme: TextTheme(
        displaySmall: displaySmallTextStyleDark,
        displayMedium: displayMediumTextStyleDark,
        displayLarge: displayLargeTextStyleDark,
        headlineSmall: headlineSmallTextStyleDark,
        headlineMedium: headlineMediumTextStyleDark,
        headlineLarge: headlineLargeTextStyleDark,
        titleSmall: titleSmallTextStyleDark,
        titleMedium: titleMediumTextStyleDark,
        titleLarge: titleLargeTextStyleDark,
        bodySmall: bodySmallTextStyleDark,
        bodyMedium: bodyMediumTextStyleDark,
        bodyLarge: bodyLargeTextStyleDark,
        labelSmall: labelSmallTextStyleDark,
        labelMedium: labelMediumTextStyleDark,
        labelLarge: labelLargeTextStyleDark,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.appBarColor,
          //      Color(0xFF97ABFF),
          //  Color(0xff123597) ,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: AppColors.colorWhite),
        backgroundColor: AppColors.appBarColor,
        titleTextStyle:
            pageTitleStyleDark.copyWith(fontFamily: _getFont(appLanguage)),
      ),
      fontFamily: _getFont(appLanguage),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.colorPrimarySwatch,
        backgroundColor: AppColors.pageBackgroundDark,
        brightness: Brightness.dark,
      ),
    );
  }

  static ThemeData getLightTheme(String appLanguage) {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      primaryColor: AppColors.colorPrimary,
      cardColor: AppColors.neutralBackground,
      iconTheme: const IconThemeData(color: AppColors.primaryGreen05),
      indicatorColor: AppColors.colorBlack,
      buttonTheme: const ButtonThemeData(alignedDropdown: true),
      dividerColor: AppColors.neutralSeparator,
      hintColor: AppColors.neutralGray,
      dialogBackgroundColor: AppColors.pageBackground,
      tabBarTheme: lightTabBarTheme,
      // textTheme: TextTheme(
      //   displaySmall: displaySmallTextStyle,
      //   displayMedium: displayMediumTextStyle,
      //   displayLarge: displayLargeTextStyle,
      //   headlineSmall: headlineSmallTextStyle,
      //   headlineMedium: headlineMediumTextStyle,
      //   headlineLarge: headlineLargeTextStyle,
      //   titleSmall: titleSmallTextStyle,
      //   titleMedium: titleMediumTextStyle,
      //   titleLarge: titleLargeTextStyle,
      //   bodySmall: bodySmallTextStyle,
      //   bodyMedium: bodyMediumTextStyle,
      //   bodyLarge: bodyLargeTextStyle,
      //   labelSmall: labelSmallTextStyle,
      //   labelMedium: labelMediumTextStyle,
      //   labelLarge: labelLargeTextStyle,
      // ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.appBarColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(color: AppColors.primaryGreen05),
        backgroundColor: AppColors.appBarColor,
        titleTextStyle:
            pageTitleStyle.copyWith(fontFamily: _getFont(appLanguage)),
      ),
      fontFamily: _getFont(appLanguage),
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.colorPrimarySwatch,
          backgroundColor: AppColors.pageBackground,
          brightness: Brightness.light),
    );
  }

  static String _getFont(String language) {
    return language == AppLanguage.bn.name ? AppFonts.bangla : AppFonts.english;
  }

  static ThemeData lightThemeFlex(String appLanguage) => FlexThemeData.light(
        scheme: FlexScheme.blueWhale,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 10,
        appBarStyle: FlexAppBarStyle.background,
        bottomAppBarElevation: 1.0,
        textTheme: TextTheme(
          displaySmall: displaySmallTextStyle,
          displayMedium: displayMediumTextStyle,
          displayLarge: displayLargeTextStyle,
          headlineSmall: headlineSmallTextStyle,
          headlineMedium: headlineMediumTextStyle,
          headlineLarge: headlineLargeTextStyle,
          titleSmall: titleSmallTextStyle,
          titleMedium: titleMediumTextStyle,
          titleLarge: titleLargeTextStyle,
          bodySmall: bodySmallTextStyle,
          bodyMedium: bodyMediumTextStyle,
          bodyLarge: bodyLargeTextStyle,
          labelSmall: labelSmallTextStyle,
          labelMedium: labelMediumTextStyle,
          labelLarge: labelLargeTextStyle,
        ),
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendTextTheme: true,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          thickBorderWidth: 2.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 15,
          inputDecoratorRadius: 10.0,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          chipRadius: 10.0,
          popupMenuRadius: 6.0,
          popupMenuElevation: 6.0,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
          appBarScrolledUnderElevation: 8.0,
          drawerWidth: 280.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 6.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarElevation: 2.0,
          navigationBarHeight: 70.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailMutedUnselectedLabel: false,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailMutedUnselectedIcon: false,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
        ),
        keyColors: const FlexKeyColors(
          useTertiary: true,
          keepPrimary: true,
          keepTertiary: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      );

  static ThemeData darkThemeFlex(String appLanguage) => FlexThemeData.dark(
        scheme: FlexScheme.barossa,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        bottomAppBarElevation: 2.0,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 40,
          blendTextTheme: true,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          thickBorderWidth: 2.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 22,
          inputDecoratorRadius: 10.0,
          chipRadius: 10.0,
          popupMenuRadius: 6.0,
          popupMenuElevation: 6.0,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
          drawerWidth: 280.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 6.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarElevation: 2.0,
          navigationBarHeight: 70.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailMutedUnselectedLabel: false,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailMutedUnselectedIcon: false,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
        ),
        keyColors: const FlexKeyColors(
          useTertiary: true,
          keepPrimary: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.notoSans().fontFamily,
      );
}



