import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class AppTheme {
  ThemeData themeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondryColor,
      ),
      fontFamily: 'inter',
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: AppColors.backGroudColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
      ),
    );
  }
}
