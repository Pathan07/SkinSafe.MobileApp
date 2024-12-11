import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/screens/home_screen.dart/widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.logoColor,
        endDrawer: customDrawer(context: context),
        appBar: customAppBar(title: "Dashboard"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20,  bottom: 10),
                child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.asset(ImageRes.skinSafeLogo),
                  ),
                ),
              ),
              textSize20(
                  text: "Welcome to SkinSafe",
                  color: AppColors.textPrimaryColor),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    homeCardWidget(
                      onTap: () =>
                          Navigator.pushNamed(context, RouteName.scanScreen),
                      iconColor: AppColors.primaryColor,
                      icon: Icons.camera_alt,
                      subTitle:
                          "Upload or capture an image of your skin for AI-powered analysis.",
                      text: "Smart Skin Scanner",
                    ),
                    homeCardWidget(
                      onTap: () =>
                          Navigator.pushNamed(context, RouteName.historyScreen),
                      iconColor: AppColors.secondryColor,
                      icon: Icons.history,
                      subTitle:
                          "Access your past scans and track changes over time.",
                      text: "View Recent History",
                    ),
                    homeCardWidget(
                      onTap: () => Navigator.pushNamed(
                          context, RouteName.educationScreen),
                      iconColor: AppColors.ratingColor,
                      icon: Icons.help_outline,
                      subTitle: "Explore educational resources on skin cancer.",
                      text: "Learn About Skin Health",
                    ),
                    homeCardWidget(
                      iconColor: AppColors.alertColor,
                      icon: Icons.security,
                      subTitle:
                          "Your data is encrypted with highest security standards.",
                      text: "Secure and Private",
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
