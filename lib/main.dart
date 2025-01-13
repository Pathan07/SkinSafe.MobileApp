import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/routes/route.dart';
import 'package:skin_safe_app/components/utilities/theme.dart';
import 'package:skin_safe_app/firebase_options.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/sign_up_screen.dart';
import 'package:skin_safe_app/screens/home%20screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Skin Safe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().themeData(),
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
      home: authState.when(
        data: (user) =>
            user != null ? const HomeScreen() : const SignUpScreen(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('Error loading app')),
      ),
    );
  }
}
