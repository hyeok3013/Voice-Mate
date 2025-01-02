import 'package:flutter/material.dart';

abstract class Palette {
  /// Chromatic color (유채색)
  static Color darkBlue = const Color(0xFF002C5F);
  static Color cyan = const Color(0xFF00AAD2);
  static Color skyBlue = const Color(0xFFAACAE6);

  /// Achromatic color (무채색)
  static Color white = const Color(0xFFFFFFFF);
  static Color white100 = const Color(0xFFFAFAFA);
  static Color grey100 = const Color(0xFFD7D7D9);
  static Color grey200 = const Color(0xFF8F8F8F);
  static Color grey300 = const Color(0xFF444444);
  static Color black = const Color(0xFF000000);
}
