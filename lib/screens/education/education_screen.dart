import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.logoColor,
      endDrawer: customDrawer(context: context),
      appBar: customAppBar(title: "Skin Health Education"),
    );
  }
}