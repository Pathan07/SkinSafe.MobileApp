import 'package:flutter/material.dart';
import 'package:skin_safe_app/screens/history/widgets/result_color.dart';

import '../../../components/custom_widgets/custom_text.dart';
import '../../../components/utilities/color.dart';

Widget buildScanCard({required String date, required String result}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: AppColors.logoColor.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textSize16(
              text: date,
              color: AppColors.textSeconderyColor,
              fontWeight: FontWeight.bold,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: resultColor(result),
                borderRadius: BorderRadius.circular(10),
              ),
              child: textSize14(
                text: result,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        textSize14(
          text:
              "Tap to view detailed analysis and recommendations for this scan.",
          color: AppColors.textSeconderyColor.withOpacity(0.7),
        ),
      ],
    ),
  );
}
