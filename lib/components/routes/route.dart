import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/screens/about/about_screen.dart';
import 'package:skin_safe_app/screens/auth_screen/login_screen.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/forget_password.dart';
import 'package:skin_safe_app/screens/auth_screen/sign_up_screen.dart';
import 'package:skin_safe_app/screens/chat_bot/chat_bot.dart';
import 'package:skin_safe_app/screens/doctor%20section/doctor%20chat/chat_screen.dart';
import 'package:skin_safe_app/screens/doctor%20section/doctor%20history/doctor_profile_history.dart';
import 'package:skin_safe_app/screens/doctor/doc_signup_screen.dart';
import 'package:skin_safe_app/screens/doctor/doctor_login_screen.dart';
import 'package:skin_safe_app/screens/education/education_screen.dart';
import 'package:skin_safe_app/screens/home%20screen/home_screen.dart';
import 'package:skin_safe_app/screens/profile/profile_screen.dart';
import 'package:skin_safe_app/screens/scan%20output/scan_output_screen.dart';
import 'package:skin_safe_app/screens/skin%20analysis/skin_analysis.dart';

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

      case RouteName.skinAnalysisScreen:
        return MaterialPageRoute(
          builder: (_) => const MelanomaDetector(),
        );

      case RouteName.historyScreen:
        return MaterialPageRoute(
          builder: (_) => const HistoryScreen1(),
        );

      case RouteName.docLogin:
        return MaterialPageRoute(
          builder: (_) => const DoctorAuth(),
        );

      case RouteName.docSignUp:
        return MaterialPageRoute(
          builder: (_) => const DocSignupScreen(),
        );

      case RouteName.scanOutputScreen:
        final argument = settings.arguments as File?;
        return MaterialPageRoute(
          builder: (_) => ScanOutputScreen(
            image: argument,
          ),
        );

      case RouteName.educationScreen:
        return MaterialPageRoute(
          builder: (_) => const EducationScreen(),
        );

      case RouteName.doctorHistory:
        final argument = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DoctorProfileHistory(
            docName: argument,
          ),
        );

      case RouteName.aboutScreen:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );

      case RouteName.doctorChat:
        return MaterialPageRoute(
          builder: (_) => const ChatScreen(),
        );

      case RouteName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case RouteName.skinSafeBot:
        return MaterialPageRoute(
          builder: (_) => const SkinSafeBot(),
        );

      case RouteName.signupScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case RouteName.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPassword(),
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
