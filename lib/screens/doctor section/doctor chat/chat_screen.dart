import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textSize20(text: 'Chat'),
        centerTitle: true,
      ),
      body: Center(
        child: textSize20(
          text: "Comming Soon...",
          color: AppColors.textSeconderyColor,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
