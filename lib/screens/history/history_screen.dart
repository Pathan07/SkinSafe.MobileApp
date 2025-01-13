import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/screens/history/scan_detail_screen.dart';
import 'package:skin_safe_app/screens/history/widgets/risk_identifier.dart';
import 'package:skin_safe_app/screens/history/widgets/scan_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample scan results for demonstration
    final List<Map<String, String>> scanResults = [
      {
        'date': '12 Jan 2025',
        'result': 'Low Risk',
        'details': 'This scan showed minimal signs of abnormality.'
      },
      {
        'date': '10 Jan 2025',
        'result': 'Medium Risk',
        'details': 'This scan indicated moderate skin irregularities.'
      },
      {
        'date': '5 Jan 2025',
        'result': 'High Risk',
        'details': 'This scan detected significant signs of melanoma risk.'
      },
    ];

    return Scaffold(
      endDrawer: customDrawer(context: context),
      appBar: AppBar(
        title: textSize20(
          text: 'Scan History',
          color: AppColors.whiteColor,
        ),
        centerTitle: true,
        backgroundColor: AppColors.logoColor,
      ),
      body: Column(
        children: [
          // Legend Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLegendItem('Low Risk', Colors.green),
                buildLegendItem('Medium Risk', Colors.orange),
                buildLegendItem('High Risk', Colors.red),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // History List
          Expanded(
            child: scanResults.isEmpty
                ? Center(
                    child: textSize16(
                      text: "No scans found.",
                      color: AppColors.textPrimaryColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.separated(
                      itemCount: scanResults.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final scan = scanResults[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanDetailScreen(
                                  date: scan['date']!,
                                  result: scan['result']!,
                                  details: scan['details']!,
                                ),
                              ),
                            );
                          },
                          child: buildScanCard(
                            date: scan['date']!,
                            result: scan['result']!,
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
