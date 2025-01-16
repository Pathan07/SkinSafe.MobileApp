import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: customDrawer(context: context),
      appBar: AppBar(
        title: textSize20(text: 'About Us'),
        centerTitle: true,
      ),
    );
  }
}
