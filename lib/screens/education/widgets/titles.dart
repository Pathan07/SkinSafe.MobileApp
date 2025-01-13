  import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

import '../../../components/custom_widgets/custom_text.dart';

Widget buildSectionHeader(String title) {
    return textSize18(
      text: title,
      fontWeight: FontWeight.bold,
      color: AppColors.textSeconderyColor,
    );
  }