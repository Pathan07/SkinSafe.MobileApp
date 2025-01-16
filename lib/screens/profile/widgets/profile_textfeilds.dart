import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class ProfileTextFields extends StatelessWidget {
  final String? name;
  final TextEditingController? controller;
  final bool? isReadAble;

  const ProfileTextFields({
    super.key,
    this.name,
    this.controller,
    this.isReadAble,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textSize16(
              color: AppColors.textSeconderyColor,
              text: name!,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                width: 2,
                color: AppColors.blackColor.withOpacity(0.2),
              ),
            ),
            child: TextField(
              controller: controller,
              readOnly: isReadAble!,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
