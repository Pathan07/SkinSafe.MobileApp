import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class AppTheme {
  ThemeData themeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.logoColor,
        primary: AppColors.logoColor,
        secondary: AppColors.whiteColor,
      ),
      fontFamily: 'inter',
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: AppColors.backGroudColor,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.logoColor,
        // centerTitle: true,
      ),
    );
  }
}
