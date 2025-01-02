part of 'app_theme.dart';

class AppTypo {
  AppTypo({
    required this.typo,
    required this.fontColor,
  }) {
    bold = typo.bold;
  }

  /// Typo
  final Typo typo;

  /// Font Weight
  late final FontWeight bold;

  /// Font Color
  final Color fontColor;

  /// Base TextStyle
  TextStyle _baseTextStyle(double fontSize) => TextStyle(
        height: 1.2.h, // 공통 height 값 사용
        fontFamily: typo.name,
        fontWeight: typo.bold,
        fontSize: fontSize,
        letterSpacing: -0.02,
        color: fontColor,
      );

  /// Title
  late final TextStyle title1 = _baseTextStyle(34.sp);
  late final TextStyle title2 = _baseTextStyle(27.sp);

  /// Subtitle
  late final TextStyle subtitle1 = _baseTextStyle(16.sp);
  late final TextStyle subtitle2 = _baseTextStyle(14.sp);

  /// Body
  late final TextStyle body1 = _baseTextStyle(12.sp);
  late final TextStyle body2 = _baseTextStyle(10.sp);
}
