import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget doctorCard({
  required String doctorName,
  required String imagePath,
  required VoidCallback onConsultPressed,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Card(
      color: AppColors.lightBlueCardColor,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.logoColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
              width: 100,
              child: Image.asset(imagePath),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textSize18(
                    text: doctorName,
                    color: AppColors.textSeconderyColor,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star, color: AppColors.ratingColor),
                      Icon(Icons.star, color: AppColors.ratingColor),
                      Icon(Icons.star, color: AppColors.ratingColor),
                      Icon(Icons.star, color: AppColors.ratingColor),
                      Icon(Icons.star, color: AppColors.ratingColor),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.logoColor,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onConsultPressed,
                    child: textSize13(
                      text: "Consult",
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
