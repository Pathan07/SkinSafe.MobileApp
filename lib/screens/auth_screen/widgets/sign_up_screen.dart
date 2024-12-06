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
final showBackButtonProvider = StateProvider<bool>((ref) => true);

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
      User? user = await authService.signUpWithEmailAndPassword(
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
                  child: Image.asset(ImageRes.skinSafeLogo),
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
                      homeScreenLoginButtons(ref: ref),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textSize16(
                                text: "Already have an account?",
                                color: AppColors.textPrimaryColor),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteName.loginScreen);
                              },
                              child: textSize16(
                                  text: "Login Now",
                                  color: AppColors.blackColor),
                            )
                          ],
                        ),
                      )
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
