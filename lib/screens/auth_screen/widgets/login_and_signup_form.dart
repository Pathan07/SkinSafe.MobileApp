import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/controllers/password_eye_toggle_controller.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);

Widget signupForm({
  required GlobalKey<FormState> formKey,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  required VoidCallback onTap,
}) {
  return Consumer(
    builder: (context, ref, child) {
      final isLoading = ref.watch(isLoadingProvider);
      final isObscure = ref.watch(passwordVisibilityProvider);

      return Form(
        key: formKey,
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //   child: textSize18(
            //     text: "Hey! Register to get started.",
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "First name",
                  errorStyle: const TextStyle(color: AppColors.whiteColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Last name",
                  errorStyle: const TextStyle(color: AppColors.whiteColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter email",
                  errorStyle: const TextStyle(color: AppColors.whiteColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.blackColor,
                    ),
                    onPressed: () {
                      print("Rebuild eye----");
                      ref.read(passwordVisibilityProvider.notifier).toggle();
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter password",
                  errorStyle: const TextStyle(color: AppColors.whiteColor),
                ),
                obscureText: isObscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Confirm password",
                  errorStyle: const TextStyle(color: AppColors.whiteColor),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                style: const TextStyle(color: AppColors.blackColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, top: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blackColor,
                    padding: EdgeInsets.zero,
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : onTap,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                          ),
                        )
                      : textSize20(
                          text: "Register",
                          color: AppColors.textPrimaryColor,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Row(
                children: [
                  const Expanded(child: Divider(thickness: 3)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: textSize16(
                      text: "Or register with",
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 3)),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// ..............................Login Form..............................\

Widget loginForm({
  required GlobalKey<FormState> formKey,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required VoidCallback onTap,
  required VoidCallback forgetPassword,
}) {
  return Consumer(
    builder: (context, ref, child) {
      final isLoading = ref.watch(isLoadingProvider);
      final isObscure = ref.watch(passwordVisibilityProvider);

      return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: textSize18(
                text:
                    "Welcome back! We're excited to have you with us again—let's keep your skin safe together!",
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                controller: passwordController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.blackColor,
                    ),
                    onPressed: () {
                      ref.read(passwordVisibilityProvider.notifier).toggle();
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your password",
                  errorStyle: const TextStyle(color: AppColors.whiteColor),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            TextButton(
              onPressed: forgetPassword,
              style: TextButton.styleFrom(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 15),
                minimumSize: const Size(
                    double.infinity, 0), 
              ),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, top: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blackColor,
                    padding: EdgeInsets.zero,
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : onTap,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                          ),
                        )
                      : textSize20(
                          text: "Login",
                          color: AppColors.textPrimaryColor,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Row(
                children: [
                  const Expanded(child: Divider(thickness: 3)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: textSize16(
                      text: "Or login with",
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 3)),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
