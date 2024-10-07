import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget textSize25({
  required String text,
  Color color = AppColors.blackColor,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget textSize30({
  required String text,
  Color color = AppColors.blackColor,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget textSize14({
  required String text,
  Color color = AppColors.textSeconderyColor,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: fontWeight,
    ),
  );
}

Widget textSize12({
  required String text,
  Color color = AppColors.textSeconderyColor,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return Text(
    textAlign: TextAlign.start,
    text,
    style: TextStyle(
      color: color,
      fontSize: 12,
    ),
  );
}

Widget textSize16({
  required String text,
  Color color = AppColors.textSeconderyColor,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return Text(
    textAlign: TextAlign.start,
    text,
    style: TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: fontWeight,
    ),
  );
}
