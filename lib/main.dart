import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/routes/route.dart';
import 'package:skin_safe_app/components/utilities/theme.dart';
import 'package:skin_safe_app/firebase_options.dart';
import 'package:skin_safe_app/screens/home_screen.dart/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin Safe',
      theme: AppTheme().themeData(),
      onGenerateRoute: ((settings) => Routes.generateRoute(settings)),
      home: const HomeScreen(),
    );
  }
}
