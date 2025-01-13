  import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "\u2022 ",
                style: TextStyle(
                    fontSize: 16, color: AppColors.textSeconderyColor),
              ),
              Expanded(
                child: textSize14(
                  algn: TextAlign.start,
                  text: item,
                  color: AppColors.textSeconderyColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }