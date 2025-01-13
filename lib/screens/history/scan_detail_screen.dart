import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/screens/history/widgets/result_color.dart';

class ScanDetailScreen extends StatelessWidget {
  final String date;
  final String result;
  final String details;

  const ScanDetailScreen({
    super.key,
    required this.date,
    required this.result,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textSize20(
          text: 'Scan Details',
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.logoColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scan Date Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.logoColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textSize20(
                    text: 'Scan Date',
                    color: AppColors.textSeconderyColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  textSize16(
                    text: date,
                    color: AppColors.textSeconderyColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Risk Level Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: resultColor(result).withOpacity(0.1),
                border: Border.all(color: resultColor(result), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: resultColor(result),
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textSize20(
                          text: 'Risk Level',
                          color: resultColor(result),
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        textSize16(
                          text: result,
                          color: resultColor(result),
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Detailed Analysis Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.logoColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textSize20(
                    text: 'Detailed Analysis',
                    color: AppColors.textSeconderyColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  textSize14(
                    text: details,
                    color: AppColors.textSeconderyColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // About the Disease Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.logoColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textSize20(
                    text: 'About the Disease',
                    color: AppColors.textSeconderyColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  textSize14(
                    algn: TextAlign.start,
                    text:
                        '1. Melanoma is a type of skin cancer that develops in melanocytes.\n'
                        '2. It can spread to other parts of the body if not detected early.\n'
                        '3. Risk factors include UV exposure, fair skin, and genetic predisposition.\n'
                        '4. Early signs include unusual moles or skin changes.\n'
                        '5. Treatment options vary from surgery to immunotherapy.',
                    color: AppColors.textSeconderyColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }  
}
