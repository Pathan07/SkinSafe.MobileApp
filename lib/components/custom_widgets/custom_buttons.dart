import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget customButton({
  required String text,
  required VoidCallback onTap,
  bool isLoading = false,
  Color backgroundColor = AppColors.logoColor,
  Color textColor = AppColors.primaryColor,
}) {
  return Container(
    margin: const EdgeInsets.only(left: 40, right: 40, top: 10),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.zero,
            elevation: 0,
          ),
          onPressed: onTap,
          child: textSize16(text: text, color: textColor)),
    ),
  );
}

Widget customIconButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return IconButton(
    icon: const Icon(Icons.info),
    onPressed: onTap,
  );
}

Widget buttonWithIcon(
    {required String text, required Widget icon, required VoidCallback onTap}) {
  return ElevatedButton.icon(
    onPressed: onTap,
    icon: icon,
    label: textSize14(
      text: text,
      color: AppColors.textPrimaryColor,
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.logoColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
