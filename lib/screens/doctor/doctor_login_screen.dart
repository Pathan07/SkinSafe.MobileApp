import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/controllers/doc_google_provider.dart';
import 'package:skin_safe_app/screens/auth_screen/service/FirebaseAuthService.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/doc_login_button.dart';
import 'package:skin_safe_app/screens/auth_screen/widgets/login_and_signup_form.dart';

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

class DoctorAuth extends ConsumerStatefulWidget {
  const DoctorAuth({super.key});

  @override
  ConsumerState<DoctorAuth> createState() => _DoctorAuthState();
}

class _DoctorAuthState extends ConsumerState<DoctorAuth> {
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

    ref.listen(docGoogleLoginProvider, (previous, next) {
      if (next.status == DocAuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, RouteName.homeScreen);
      } else if (next.status == DocAuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error ?? 'Unknown error')),
        );
      }
    });

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
                  child: Image.asset(ImageRes.doctorLogo),
                ),
              ),
              textSize40(text: "Skin Safe"),
              authState.when(
                data: (user) {
                  return Column(
                    children: [
                      docLoginForm(
                        forgetPassword: () {
                          Navigator.pushNamed(
                              context, RouteName.forgetPassword);
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
                      const SizedBox(height: 20),
                      docAuthScreenLogin(ref: ref),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.docSignUp);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textSize16(
                                text: "Don't have an account?",
                                color: AppColors.whiteColor),
                            const SizedBox(width: 10),
                            textSize16(
                              text: "Sign Up",
                              color: AppColors.blackColor,
                            ),
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
