import 'package:flutter/material.dart';
import 'package:voice_mate/src/theme/foundation/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:voice_mate/src/theme/light_theme.dart';

class ThemeService {
  /// 현재 테마
  final AppTheme theme = LightTheme();

  /// Material ThemeData 커스텀
  ThemeData get themeData {
    return ThemeData(
      /// Scaffold
      scaffoldBackgroundColor: theme.color.background,

      /// AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: theme.color.background,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: theme.color.text,
        ),
        titleTextStyle: theme.typo.title1.copyWith(
          color: theme.color.text,
        ),
      ),
    );
  }
}

extension ThemeServiceExt on BuildContext {
  ThemeService get themeService => read<ThemeService>();
  AppTheme get theme => themeService.theme;
  AppColor get color => theme.color;
  AppDeco get deco => theme.deco;
  AppTypo get typo => theme.typo;
}
