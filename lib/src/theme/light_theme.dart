import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'foundation/app_theme.dart';
import 'res/palette.dart';
import 'res/typo.dart';

class LightTheme implements AppTheme {
  @override
  Brightness brightness = Brightness.light;

  @override
  AppColor color = AppColor(
    surface: Palette.white,
    background: Palette.white100,
    text: Palette.darkBlue,
    subtext: Palette.black,
    // toastContainer: Palette.black.withOpacity(0.85),
    // onToastContainer: Palette.grey100,
    // hint: Palette.grey300,
    // hintContainer: Palette.grey150,
    // onHintContainer: Palette.grey500,
    inactive: Palette.white,
    inactiveContainer: Palette.grey100,
    // onInactiveContainer: Palette.white,
    primary: Palette.darkBlue,
    onPrimary: Palette.white,
    secondary: Palette.cyan,
    // onSecondary: Palette.white,
    // tertiary: Palette.yellow,
    // onTertiary: Palette.white,
  );

  @override
  late AppTypo typo = AppTypo(
    typo: const Pretendard(),
    fontColor: color.text,
  );

  @override
  AppDeco deco = AppDeco(
    shadow: [
      BoxShadow(
        color: Palette.black.withOpacity(0.15), // 15% opacity
        offset: Offset(0, 1.h), // X: 0, Y: 1
        blurRadius: 5, // Blur: 5
        spreadRadius: 0, // Spread: 0
      ),
    ],
  );
}
