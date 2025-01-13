import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget buildHomeCard(
  BuildContext context, {
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: AppColors.whiteColor),
          const SizedBox(height: 10),
          textSize16(
            text: title,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 5),
          textSize12(
            text: subtitle,
            color: AppColors.whiteColor.withOpacity(0.9),
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    ),
  );
}
