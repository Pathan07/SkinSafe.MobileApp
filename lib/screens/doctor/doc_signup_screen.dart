import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/controllers/google_login.controller.dart';
import 'package:skin_safe_app/screens/auth_screen/service/FirebaseAuthService.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/login_and_signup_form.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/login_buttons.dart';

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final showBackButtonProvider = StateProvider<bool>((ref) => true);

class DocSignupScreen extends ConsumerStatefulWidget {
  const DocSignupScreen({super.key});

  @override
  ConsumerState<DocSignupScreen> createState() => _DocSignupState();
}

class _DocSignupState extends ConsumerState<DocSignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuthService authService = FirebaseAuthService();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void signUp() async {
    ref.read(isLoadingProvider.notifier).state = true;

    String email = emailController.text;
    String password = passwordController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;

    try {
      User? user = await authService.docSignUp(
          email,
          password,
          firstName,
          lastName,
          'https://www.gstatic.com/images/branding/product/1x/avatar_square_blue_512dp.png',
          context);
      if (user != null) {
        print(user.providerData);
        ref.read(showBackButtonProvider.notifier).state = false;
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.homeScreen,
            (Route<dynamic> route) => false,
          );
        }
      } else {
        print("Error: User sign-up failed.");
      }
    } catch (e) {
      print("Sign up error: $e");
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild.............");
    print("Rebuild eye----");
    final authState = ref.watch(authStateProvider);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ref.listen(googleLoginProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, RouteName.homeScreen);
      } else if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error ?? 'Unknown error')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: textSize18(
            text: 'Register to get started', fontWeight: FontWeight.normal),
        centerTitle: true,
      ),
      backgroundColor: AppColors.logoColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: CircleAvatar(
                  radius: 80,
                  child: Image.asset(ImageRes.doctorLogo),
                ),
              ),
              textSize40(text: "Skin Safe"),
              authState.when(
                data: (user) {
                  return Column(
                    children: [
                      signupForm(
                        formKey: formKey,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                      ),
                      const SizedBox(height: 20),
                      homeScreenLoginButtons(ref: ref),
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
