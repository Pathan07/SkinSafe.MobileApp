import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/screens/education/widgets/before_after_card.dart';
import 'package:skin_safe_app/screens/education/widgets/titles.dart';

Widget buildBeforeAfterSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader("Melanoma Before and After Treatment"),
      const SizedBox(height: 10),
      Row(
        children: [
          beforeAndAfterCard(
              imagePath: ImageRes.melanomaBefore, caption: "Before Treatment"),
          const SizedBox(width: 10),
          beforeAndAfterCard(
              imagePath: ImageRes.melanomaAfter, caption: "After Treatment")
        ],
      ),
    ],
  );
}
