import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: customDrawer(context: context),
      appBar: customAppBar(title: "About SkinSafe"),
    );
  }
}
