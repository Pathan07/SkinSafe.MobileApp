  import 'package:flutter/material.dart';
  import 'package:skin_safe_app/components/custom_app_bar.dart';
  import 'package:skin_safe_app/components/custom_drawer.dart';
  import 'package:skin_safe_app/components/custom_text.dart';
  import 'package:skin_safe_app/components/routes/route_name.dart';
  import 'package:skin_safe_app/components/utilities/color.dart';
  import 'package:skin_safe_app/components/utilities/images.dart';

  class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          endDrawer: customDrawer(context: context),
          appBar: customAppBar(title: "Welcome to SkinSafe"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child: Image.asset(
                        ImageRes.skinSafeLogo,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  child: GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.95,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: [
                      homeCardWidget(
                        onTap: () =>
                            Navigator.pushNamed(context, RouteName.scanScreen),
                        iconColor: AppColors.primaryColor,
                        icon: Icons.camera_alt,
                        subTitle: "Upload or capture an image of your skin for AI-powered analysis.",
                        text: "Smart Skin Scanner",
                      ),
                      homeCardWidget(
                        onTap: () =>
                            Navigator.pushNamed(context, RouteName.historyScreen),
                        iconColor: AppColors.secondryColor,
                        icon: Icons.history,
                        subTitle: "Access your past scans and track changes over time.",
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
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget homeCardWidget(
      {required IconData icon,
      required Color iconColor,
      required String text,
      VoidCallback? onTap,
      required String subTitle}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 8,
            right: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: 35,
                  ),
                  Expanded(
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: textSize16(
                            text: text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: textSize14(
                     text: subTitle, overFlow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
      ),
    );
  }
