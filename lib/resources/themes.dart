import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/resources/assets/fonts.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:in_the_kloud_app/resources/constants.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData AppThemeData = ThemeData(
    fontFamily: AppFonts.interFamily,
    primarySwatch: AppColors.toMaterialColor(AppColors.Green),
    disabledColor: AppColors.LightGrey,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
          color: AppColors.lynxWhite,
          fontWeight: FontWeight.w800,
          fontSize: 26),
      titleLarge: TextStyle(
          overflow: TextOverflow.visible,
          color: AppColors.lynxWhite,
          fontWeight: FontWeight.w800,
          fontSize: 20),
      labelLarge:
          TextStyle(color: AppColors.Green, fontWeight: FontWeight.w600),
    ),
    iconTheme: IconThemeData(color: AppColors.Green),
    shadowColor: AppColors.grey_400,
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      iconColor: AppColors.Green,
    ),
  );
}
