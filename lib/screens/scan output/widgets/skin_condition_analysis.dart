import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget scanAnalysisCard() {
  return Card(
    color: AppColors.lightBlueCardColor,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your skin scan indicates signs consistent with melanoma, a form of skin cancer. "
            "The risk stage is high, and immediate consultation with a dermatologist is highly recommended. "
            "Early detection and timely medical advice are crucial for effective management.",
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              textSize16(text: "Category: "),
              textSize14(text: "Melanoma"),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              textSize16(text: "Risk Stage: "),
              textSize14(text: "High"),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              textSize16(text: "Consultation Needed: "),
              textSize14(text: "Highly Recommended"),
            ],
          ),
        ],
      ),
    ),
  );
}
