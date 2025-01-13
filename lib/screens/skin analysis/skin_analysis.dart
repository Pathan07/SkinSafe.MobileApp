import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_buttons.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class SkinAnalysis extends StatefulWidget {
  const SkinAnalysis({super.key});

  @override
  State<SkinAnalysis> createState() => _SkinAnalysisState();
}

class _SkinAnalysisState extends State<SkinAnalysis> {
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textSize20(text: 'Skin Analysis'),
        centerTitle: true,
        actions: [
          customIconButton(icon: Icons.info, onTap: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
              child: textSize22(
                text: "Upload Skin Photo",
                color: AppColors.textSeconderyColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: textSize14(
                text:
                    "Please upload a clear photo of skin for analysis. Ensure good lighting and focus on the area of concern.",
                fontWeight: FontWeight.normal,
              ),
            ),
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text('No image selected.'),
                        ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: AppColors.alertColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: textSize14(
                        fontWeight: FontWeight.bold,
                        text: "NOTE:",
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    Expanded(
                      child: textSize14(
                        text:
                            "We recommend you to upload an image of \n300 X 300 for better results.",
                        color: AppColors.alertColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: textSize13(text: "Accepted file types: JPG, PNG"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
              child: textSize14(
                text:
                    "Our melanoma detection process uses advanced AI to analyze your skin photo and provide a detailed report.",
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _selectedImage == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonWithIcon(
                    onTap: _pickImageFromGallery,
                    icon: const Icon(Icons.image, color: AppColors.whiteColor),
                    text: "Gallery",
                  ),
                  buttonWithIcon(
                    onTap: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt,
                        color: AppColors.whiteColor),
                    text: "Camera",
                  ),
                ],
              )
            : customButton(
                textColor: AppColors.textPrimaryColor,
                backgroundColor: AppColors.logoColor,
                text: "Scan",
                onTap: () {
                  Navigator.pushNamed(context, RouteName.scanOutputScreen,
                      arguments: _selectedImage);
                },
              ),
      ),
    );
  }
}
