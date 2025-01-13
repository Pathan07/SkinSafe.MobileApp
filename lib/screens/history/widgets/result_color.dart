import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Color resultColor(String result) {
  switch (result) {
    case 'Low Risk':
      return Colors.green;
    case 'Medium Risk':
      return Colors.orange;
    case 'High Risk':
      return Colors.red;
    default:
      return AppColors.logoColor;
  }
}
