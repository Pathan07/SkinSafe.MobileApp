import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget beforeAndAfterCard(
    {required String imagePath, required String caption}) {
  return Expanded(
    child: Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        textSize14(
          text: caption,
          color: AppColors.textSeconderyColor,
        ),
      ],
    ),
  );
}
