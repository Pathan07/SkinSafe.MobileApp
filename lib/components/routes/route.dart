import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/screens/home_screen.dart/home_screen.dart';
import 'package:skin_safe_app/screens/profile/profile_screen.dart';

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
