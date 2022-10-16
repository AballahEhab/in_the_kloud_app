import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/resources/colors.dart';

class Constants {
  static final Radius SingInBoxRadius = Radius.circular(16);
  static final Radius SearchBoxRadius = Radius.circular(50);

  static final BorderRadius ElevatedButtonBorderRadius =
      BorderRadius.circular(30.0);

  static final List<BoxShadow> SingInBoxShadow = [
    BoxShadow(blurRadius: 5, offset: Offset(0, 4), color: AppColors.grey_400)
  ];

  static const double AppCustomTextFieldTrailingIconSize = 26;
  static const double AppCustomSearchBarIconSize = 22;
  static const double SingInDecorationImageOpacity = .1;

  static var GridCrossAxisCount = 2;


  static const Map<String, String> DeafualtHttpRequestHeaders = {
    "Accept": "*/*",
    "Content-Type": "application/json"
  };


  static const double match_parent = double.infinity;
  static const double $5px = 5;
  static const double $8px = 8;
  static const double $12px = 12;
  static const double $15px = 15;
  static const double $20px = 20;
  static const double $35px = 35;
  static const double $40px = 40;
  static const double $45px = 45;
  static const double $50px = 50;
  static const double $55px = 55;
  static const double $60px = 60;
  static const double $75px = 75;

}
