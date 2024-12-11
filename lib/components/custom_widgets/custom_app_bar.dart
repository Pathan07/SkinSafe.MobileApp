import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';

PreferredSizeWidget customAppBar({
  required String title,
}) {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 50),
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: textSize25(text: title),
      ),
    ),
  );
}
