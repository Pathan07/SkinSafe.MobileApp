import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';

Widget homeScreenLoginButtons({required WidgetRef ref}) {
  return SeabeeStudyLoginButtons(
    onTap: () async {
      print("Click Google btn");
      // await ref.read(googleLoginProvider.notifier).signInWithGoogle();
    },
    icon: ImageRes.googleLogo,
  );
}

class SeabeeStudyLoginButtons extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const SeabeeStudyLoginButtons({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
