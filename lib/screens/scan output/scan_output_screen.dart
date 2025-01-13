import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';
import 'package:skin_safe_app/screens/scan%20output/widgets/doc_card.dart';
import 'package:skin_safe_app/screens/scan%20output/widgets/skin_condition_analysis.dart';

class ScanOutputScreen extends StatelessWidget {
  final File? image;
  const ScanOutputScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: textSize20(text: 'Skin Results'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: image == null
            ? const Center(
                child: Text(
                  'No image selected',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textSize22(
                          text: "Scanned Image",
                          color: AppColors.textSeconderyColor),
                      SizedBox(
                        height: 350,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Skin Condition Analysis',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      scanAnalysisCard(),
                      doctorCard(
                          doctorName: "Dr. Waqas (MBBS)",
                          imagePath: ImageRes.doctorLogo,
                          onConsultPressed: () {
                            Navigator.pushNamed(context, RouteName.doctorHistory,
                                arguments: "Dr. Waqas (MBBS)");
                          }),
                      doctorCard(
                          doctorName: "Dr. Sabir (MBBS)",
                          imagePath: ImageRes.doctorLogo,
                          onConsultPressed: () {
                            Navigator.pushNamed(context, RouteName.doctorHistory,
                                arguments: "Dr. Sabir (MBBS)");
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
