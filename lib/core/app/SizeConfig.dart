import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;
  static late double _equivalentPixels;


  void init({
    required BuildContext context,
    required int numOfHorizontalUnits,
    required int numOfVerticalUnits,
  }) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    var safePadding = mediaQueryData.viewPadding.top;
    _blockSizeHorizontal = screenWidth / numOfHorizontalUnits;
    _blockSizeVertical = (screenHeight - safePadding) / numOfVerticalUnits;
  }

  double setHorizontalSizeWithUnits(double unmOfUnis) =>
      _blockSizeHorizontal * unmOfUnis;

  double setVerticalSizeWithUnits(double unmOfUnis) =>
      _blockSizeVertical * unmOfUnis;

  void initWithRatio(
      {required BuildContext context,
      required double designWidth}) {
    _equivalentPixels =MediaQuery.of(context).size.width/ designWidth;
  }


  double toDynamicUnit(double unmOfUnis) =>
      _equivalentPixels * unmOfUnis;
}
