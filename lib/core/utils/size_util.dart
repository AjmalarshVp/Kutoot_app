import 'package:flutter/material.dart';

class SizeUtil {
  static late MediaQueryData _mediaQueryData;
  static late MediaQueryData _dynamicMediaQueryData;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _dynamicMediaQueryData = MediaQuery.of(context);
  }

  static MediaQueryData get mediaQuery => _mediaQueryData;
  static int get baseHeight => 913;
  static int get baseWidth => 375;
  static MediaQueryData get landscapeMediaQuery => _dynamicMediaQueryData;

  static double setHeight(num height) =>
      height * mediaQuery.size.height / baseHeight;

  static double setWidth(num width) =>
      width * mediaQuery.size.width / baseWidth;

  static double setSp(num size) =>
      size * mediaQuery.size.width / baseWidth;
}

extension SizeExt on num {
  double get h => SizeUtil.setHeight(this);
  double get w => SizeUtil.setWidth(this);
  double get sp => SizeUtil.setSp(this);
  double get r => SizeUtil.setWidth(this);
}
