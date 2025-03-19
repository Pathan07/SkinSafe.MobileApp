import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/screens/auth_screen/service/FirebaseAuthService.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/login_and_signup_form.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/login_buttons.dart';

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuthService authService = FirebaseAuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() async {
    ref.read(isLoadingProvider.notifier).state = true;

    String email = emailController.text;
    String password = passwordController.text;

    try {
      User? user = await authService.loginUser(email, password, context);
      if (user != null) {
        // print(user.email);
        print(user.providerData);
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.homeScreen,
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      print("Sign-in error: ${e.toString()}");
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      backgroundColor: AppColors.logoColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: CircleAvatar(
                  radius: 80,
                  child: Image.asset(ImageRes.skinSafeLogo),
                ),
              ),
              textSize40(text: "Skin Safe"),
              authState.when(
                data: (user) {
                  return Column(
                    children: [
                      loginForm(
                        forgetPassword: () {
                          Navigator.pushNamed(context, RouteName.forgetPassword);
                        },
                        formKey: formKey,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            signIn();
                          }
                        },
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      // homeScreenLoginButtons(ref: ref),
                      const SizedBox(height: 20),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
