import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: customDrawer(context: context),
        appBar: customAppBar(title: "Scan Your Skin"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightGreyCardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    color: AppColors.primaryColor,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: textSize25(
                        text: "Scan Your Skin", color: AppColors.primaryColor),
                  ),
                  textSize16(
                    fontWeight: FontWeight.normal,
                    text: "Capture or upload an image for AI analysis.",
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.1),
                blurRadius: 5.0,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt,
                    color: AppColors.whiteColor,
                  ),
                  label: textSize12(
                      text: "Open Camera", color: AppColors.textPrimaryColor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.upload,
                    color: AppColors.whiteColor,
                  ),
                  label: textSize12(
                      text: "Upload Image", color: AppColors.textPrimaryColor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
