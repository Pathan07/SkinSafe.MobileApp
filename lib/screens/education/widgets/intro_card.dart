import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget buildIntroductionSection() {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: AppColors.logoColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: textSize16(
      fontWeight: FontWeight.normal,
      align: TextAlign.center,
      text:
          "Melanoma is a type of skin cancer that can develop from the pigment-producing cells called melanocytes. Early detection and awareness are crucial for effective treatment.",
      color: AppColors.textSeconderyColor,
    ),
  );
}
