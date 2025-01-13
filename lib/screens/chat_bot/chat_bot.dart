import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

const String giminiApiKey = "AIzaSyBSd-DtFNc9-Mk4jRagSzecsNRvuitvRYQ";

class ChatBot extends ConsumerStatefulWidget {
  const ChatBot({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatBotState();
}

class _ChatBotState extends ConsumerState<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.logoColor,
      appBar: customAppBar(title: 'Skin Safe Bot'),
      endDrawer: customDrawer(context: context),
      
    );
  }
}
