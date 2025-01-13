import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/screens/education/widgets/before_after_template.dart';
import 'package:skin_safe_app/screens/education/widgets/bullet_list.dart';
import 'package:skin_safe_app/screens/education/widgets/intro_card.dart';
import 'package:skin_safe_app/screens/education/widgets/titles.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: customDrawer(context: context),
      appBar: AppBar(
        title: textSize20(
          text: 'Educational Guide',
          color: AppColors.whiteColor,
        ),
        centerTitle: true,
        backgroundColor: AppColors.logoColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction Section
              buildIntroductionSection(),
              const SizedBox(height: 20),

              // Symptoms Section
              buildSectionHeader("Symptoms of Melanoma"),
              const SizedBox(height: 10),
              buildBulletList([
                "A new spot or growth on the skin.",
                "Changes in size, shape, or color of an existing mole.",
                "A mole that bleeds, itches, or is painful.",
                "Dark spots on the palms, soles, or under the nails.",
              ]),
              const SizedBox(height: 20),

              // Risk Factors Section
              buildSectionHeader("Risk Factors"),
              const SizedBox(height: 10),
              buildBulletList([
                "Excessive exposure to UV rays from the sun or tanning beds.",
                "Family history of melanoma or other skin cancers.",
                "Having fair skin, freckles, or light hair.",
                "Weakened immune system.",
                "Large or unusual moles on the skin.",
              ]),
              const SizedBox(height: 20),

              // Prevention Tips Section
              buildSectionHeader("Prevention Tips"),
              const SizedBox(height: 10),
              buildBulletList([
                "Wear sunscreen with a high SPF daily.",
                "Avoid prolonged exposure to the sun, especially between 10 AM and 4 PM.",
                "Wear protective clothing, hats, and sunglasses.",
                "Avoid tanning beds and artificial UV sources.",
                "Perform regular self-examinations and consult a dermatologist for any changes.",
              ]),
              const SizedBox(height: 20),
              buildBeforeAfterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
