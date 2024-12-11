import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_bottom_bar.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/screens/chat_bot/chat_bot.dart';
import 'package:skin_safe_app/screens/history/history_screen.dart';
import 'package:skin_safe_app/screens/home_screen.dart/home_screen.dart';
import 'package:skin_safe_app/screens/profile/profile_screen.dart';
import 'package:skin_safe_app/screens/scan/scan_screen.dart';

class InitinalScreen extends StatefulWidget {
  const InitinalScreen({super.key});

  @override
  State<InitinalScreen> createState() => InitinalScreenState();
}

class InitinalScreenState extends State<InitinalScreen> {
  int currentTab = 0;

  late final List<Widget> screens = [
    const HomeScreen(),
    const ScanScreen(),
    const ChatBot(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  late Widget currentScreen = screens[0];

  void _onTabSelected(int index) {
    setState(() {
      currentScreen = screens[index];
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding home screen.....");
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: currentScreen,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentTab: currentTab,
        onTabSelected: (index) => _onTabSelected(index),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.ratingColor,
        shape: const CircleBorder(),
        onPressed: () => _onTabSelected(2),
        child: const Icon(
          Icons.auto_awesome,
          color: AppColors.blackColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
