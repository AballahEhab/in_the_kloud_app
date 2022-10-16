
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{

  AppColors._();

  static const  transparent = Colors.transparent;
  static const  White = Colors.white;
  static const  lynxWhite = Color(0xFFF7F7F7);

  static final  grey_200 = Colors.grey[200]!;

  static const lighterGray = Color(0x3DE8E8E8);
  static const  BottomNavigationBarColor = Color(0xFFE2E2E2);

  static final  grey_400 = Colors.grey[400]!;  //189

  static const IconsNotSelected = Color(0xFFA7A7A7); //disabled icon navigation

  static final  grey_600 = Colors.grey[600]!;

  static const  LightGrey = Color(0xFF707070);
  static const  Black = Colors.black;
  static const  DarkGrey = Color(0xFF313837);

  static final  Red = Colors.red[900];

  static const  RemoveColor = Color(0xFF724343);
  static const  darkRed = Color(0xFF770B0B);
  static const  CircleAvatarBackGround = Color(0xFF2F5B78);
  static const  NotificationLabel = Color(0xFF53D3C2);
  static const  Green = Color(0xFF43726C);
  static const  categoryGreenLight = Color(0xFF42726B);
  static const  AddToCartGreen = Color(0xFF3A645E);
  static const  GrayGreen = Color(0xFF3C4B49);
  static const  DarkGreen = Color(0xFF233C38);
  static const  productDetaDescBoxGrad1 = Color(0xFF315651);
  static const  productDetaTotalBoxGrad = Color(0xFFCDCBCB);
  static const  productDetaCountBoxGrad1 = Color(0xFF223A37);
  static const  productDetaCountBoxGrad2 = Color(0xFF43716B);
  static const  cartItemBoxGrad1 = Color(0xFFE1E1E1);

  static const  bottomNavigationBarGrad = Color(0xFFE2E2E2);

  static const  enabledNavigationIcon = Color(0xFF769792);

  static const  cartPageTitleColor = Color(0xFF5C5C5C);

  static const  productAddToCartButtonColor2 = Color(0xFF325853);





  static const SearchBoxGradiantColors =[GrayGreen,Green];
  static const CategoryGradiantColors =[DarkGreen,Green];
  static const BottomNavigationBarGradiantColors =[BottomNavigationBarColor,White];




  static MaterialColor toMaterialColor(Color color){
    int r = color.red;
    int g = color.green;
    int b = color.blue;
    Map<int, Color> colorTints =
    {
      50:Color.fromRGBO(r,g,b, .1),
      100:Color.fromRGBO(r,g,b, .2),
      200:Color.fromRGBO(r,g,b, .3),
      300:Color.fromRGBO(r,g,b, .4),
      400:Color.fromRGBO(r,g,b, .5),
      500:Color.fromRGBO(r,g,b, .6),
      600:Color.fromRGBO(r,g,b, .7),
      700:Color.fromRGBO(r,g,b, .8),
      800:Color.fromRGBO(r,g,b, .9),
      900:Color.fromRGBO(r,g,b, 1),
    };
    return MaterialColor(Color.fromRGBO(r,g,b, 1).value, colorTints);

  }

}