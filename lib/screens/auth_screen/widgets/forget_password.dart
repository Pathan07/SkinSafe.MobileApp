import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/screens/auth_screen/service/firebaseAuthService.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final FirebaseAuthService authService = FirebaseAuthService();

    return Scaffold(
      appBar: customAppBar(title: "Reset your password"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 250,
                child: Image.asset(ImageRes.skinSafeLogo),
              ),
            ),
            textSize18(text: "Enter your email to receive a reset link"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextFormField(
                controller: emailController,
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your email",
                  errorStyle: const TextStyle(color: AppColors.whiteColor),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: AppColors.blackColor),
                  onPressed: () async {
                    String email = emailController.text.trim();
                    // Clear any currently visible SnackBars
                    ScaffoldMessenger.of(context).clearSnackBars();

                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter email address.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      await authService.sendPasswordResetEmail(email, context);
                    }
                    Navigator.pop(context);
                  },
                  child: textSize20(
                      text: "Reset Password",
                      color: AppColors.textPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
