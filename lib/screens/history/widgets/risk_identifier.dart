import 'package:flutter/material.dart';

import '../../../components/custom_widgets/custom_text.dart';
import '../../../components/utilities/color.dart';

Widget buildLegendItem(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 8),
      textSize14(
        text: label,
        color: AppColors.textSeconderyColor,
      ),
    ],
  );
}
