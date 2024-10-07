import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/screens/about/about_screen.dart';
import 'package:skin_safe_app/screens/education/education_screen.dart';
import 'package:skin_safe_app/screens/history/history_screen.dart';
import 'package:skin_safe_app/screens/home_screen.dart/home_screen.dart';
import 'package:skin_safe_app/screens/profile/profile_screen.dart';
import 'package:skin_safe_app/screens/scan/scan_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case RouteName.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case RouteName.scanScreen:
        return MaterialPageRoute(
          builder: (_) => const ScanScreen(),
        );

      case RouteName.historyScreen:
        return MaterialPageRoute(
          builder: (_) => const HistoryScreen(),
        );

      case RouteName.educationScreen:
        return MaterialPageRoute(
          builder: (_) => const EducationScreen(),
        );

      case RouteName.aboutScreen:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error: This page doesn\'t exist'),
            ),
          ),
        );
    }
  }
}
