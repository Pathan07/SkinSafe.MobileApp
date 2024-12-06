import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class EducationScreen extends StatelessWidget {
  EducationScreen({super.key});
  final List<Map<String, String>> melanomaArticle = [
    {
      'title': 'What is Melanoma?',
      'description':
          'Melanoma is a serious type of skin cancer that begins in the cells known as melanocytes. These cells produce melanin, the pigment that gives skin its color. Melanoma can develop in any part of the skin, but it is more common in areas frequently exposed to sunlight, such as the back, legs, arms, and face. Unlike other skin cancers, melanoma is more likely to spread to other parts of the body if not treated early.',
      // 'image': 'assets/melanoma_what.png',
    },
    {
      'title': 'Risk Factors',
      'description': 'The risk of melanoma is influenced by several factors:\n'
          '1. UV Exposure : Ultraviolet (UV) radiation from sunlight and tanning beds is a significant risk factor. Prolonged exposure can damage skin cells, leading to melanoma.\n'
          '2. Skin Type: People with fair skin, freckles, and light-colored hair are more susceptible to melanoma because they have less melanin, which provides some protection against UV radiation.\n'
          '3. Family History: A family history of melanoma can increase your risk, as certain genetic factors may be inherited.\n'
          '4. Moles: People with many moles or unusual moles are at higher risk of developing melanoma.',
      // 'image': 'assets/risk_factors.png',
    },
    {
      'title': 'Signs and Symptoms (ABCDE Rule)',
      'description': 'Melanoma often appears as a new spot on the skin or as a change in an existing mole. Here’s the ABCDE rule to help identify warning signs:\n'
          '• A - Asymmetry: One half of the mole does not match the other.\n'
          '• B - Border: Irregular, scalloped, or poorly defined borders.\n'
          '• C - Color: Varied colors, including shades of black, brown, and tan.\n'
          '• D - Diameter: The mole is usually larger than 6mm (about the size of a pencil eraser).\n'
          '• E - Evolving: Any change in size, shape, color, or elevation of a mole, or any new symptom such as bleeding, itching, or crusting.',
      // 'image': 'assets/signs_symptoms.png',
    },
    {
      'title': 'Prevention Tips',
      'description': 'To reduce the risk of melanoma, follow these precautions:\n'
          '1. Sun Protection: Use a broad-spectrum sunscreen with SPF 30 or higher, even on cloudy days. Wear protective clothing, hats, and sunglasses when outdoors.\n'
          '2. Avoid Tanning Beds: Tanning beds emit harmful UV rays, which increase the risk of skin cancer.\n'
          '3. Regular Skin Checks: Examine your skin monthly for any new moles or changes in existing ones. Early detection is key to successful treatment.\n'
          '4. Visit a Dermatologist: Get a professional skin check annually, especially if you have a history of sunburns, fair skin, or family history of melanoma.',
      // 'image': 'assets/prevention.png',
    },
    {
      'title': 'Treatment Options',
      'description': 'Treatment for melanoma depends on the stage of the cancer:\n'
          '• Early-stage: Surgical removal of the melanoma is often effective if detected early.\n'
          '• Advanced melanoma: If melanoma has spread, treatments may include immunotherapy, targeted therapy, radiation, or chemotherapy. Immunotherapy helps boost the immune system to attack melanoma cells, while targeted therapy uses drugs to target specific mutations in melanoma cells.',
      // 'image': 'assets/treatment.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.logoColor,
      endDrawer: customDrawer(context: context),
      appBar: customAppBar(title: "Skin Health Education"),
      body: ListView.builder(
        itemCount: melanomaArticle.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textSize20(
                      color: AppColors.textSeconderyColor,
                      text: melanomaArticle[index]['title']!,
                    ),
                    // const SizedBox(height: 8),
                    // Image.asset(
                    //   melanomaArticle[index]['image']!,
                    //   height: 150,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    const SizedBox(height: 8),
                    textSize16(
                        text: melanomaArticle[index]['description']!,
                        fontWeight: FontWeight.normal),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
