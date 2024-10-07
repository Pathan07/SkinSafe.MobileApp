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
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyCardColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[400],
                      size: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt,color: AppColors.whiteColor,),
                    label: textSize12(
                        text: "Upload Image",
                        color: AppColors.textPrimaryColor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.upload,
                      color: AppColors.whiteColor,
                    ),
                    label: textSize12(
                        text: "Upload Image",
                        color: AppColors.textPrimaryColor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
