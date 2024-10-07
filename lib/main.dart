import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/routes/route.dart';
import 'package:skin_safe_app/components/utilities/theme.dart';
import 'package:skin_safe_app/screens/home_screen.dart/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skin Safe',
      theme: AppTheme().themeData(),
      onGenerateRoute: ((settings) => Routes.generateRoute(settings)),
      home: const HomeScreen(),
    );
  }
}
