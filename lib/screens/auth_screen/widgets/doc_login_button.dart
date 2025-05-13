import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/controllers/doc_google_provider.dart';

Widget docAuthScreenLogin({required WidgetRef ref}) {
  return DoctorAutGoogleLogin(
    onTap: () async {
      print("Click Google btn");
      await ref.read(docGoogleLoginProvider.notifier).signInWithGoogle();
    },
    icon: ImageRes.googleLogo,
  );
}

class DoctorAutGoogleLogin extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const DoctorAutGoogleLogin({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: AppColors.backGroudColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.backGroudColor,
            padding: EdgeInsets.zero,
            elevation: 0,
          ),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  height: 28,
                  width: 28,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: textSize18(
                    text: 'Continue with Google',
                    color: AppColors.textSeconderyColor,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
