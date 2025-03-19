import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/screens/home%20screen/widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      endDrawer: customDrawer(context: context),
      appBar: AppBar(
        title: textSize20(text: 'Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.whiteColor.withOpacity(0.8),
                child: ClipOval(
                  child: Image.asset(ImageRes.skinSafeLogo, fit: BoxFit.cover),
                ),
              ),
            ),
            textSize22(
              text: "Welcome to SkinSafe",
              color: AppColors.textSeconderyColor,
              font: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            textSize14(
              text: "Your personalized AI-powered skin health assistant.",
              color: AppColors.textSeconderyColor.withOpacity(0.8),
            ),
            const SizedBox(height: 20),
            // Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final items = [
                    {
                      'title': "Smart Skin Scanner",
                      'subtitle':
                          "Upload or capture an image of your skin for AI-powered analysis.",
                      'icon': Icons.camera_alt,
                      'color': AppColors.primaryColor,
                      'route': RouteName.skinAnalysisScreen,
                    },
                    {
                      'title': "View Recent History",
                      'subtitle':
                          "Access your past scans and track changes over time.",
                      'icon': Icons.history,
                      'color': AppColors.secondryColor,
                      'route': RouteName.historyScreen,
                    },
                    {
                      'title': "Learn About Skin Health",
                      'subtitle':
                          "Explore educational resources on skin cancer.",
                      'icon': Icons.help_outline,
                      'color': AppColors.alertColor,
                      'route': RouteName.educationScreen,
                    },
                    {
                      'title': "Consult With Doctor",
                      'subtitle': "Consult your problem with experts.",
                      'icon': Icons.medical_services_outlined,
                      'color': AppColors.alertColor,
                      'route': RouteName.doctorChat,
                    },
                  ];

                  return buildHomeCard(
                    context,
                    title: items[index]['title'] as String,
                    subtitle: items[index]['subtitle'] as String,
                    icon: items[index]['icon'] as IconData,
                    color: items[index]['color'] as Color,
                    onTap: items[index]['route'] != null
                        ? () => Navigator.pushNamed(
                              context,
                              items[index]['route'] as String,
                            )
                        : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
