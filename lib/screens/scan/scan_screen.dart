import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/controllers/scan_screen_controller.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanState = ref.watch(scanProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.logoColor,
        endDrawer: customDrawer(context: context),
        appBar: customAppBar(title: "Scan Your Skin"),
        body: Container(
          margin: const EdgeInsets.all(20),
          height: 250,
          width: double.infinity,
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
          child: scanState.when(
            data: (file) {
              if (file == null) {
                return const Center(
                    child: Text(
                  'No Image is Selected.',
                  style: TextStyle(color: AppColors.textSeconderyColor),
                ));
              }
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                  ));
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(
              'Error: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.logoColor,
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await ref.read(scanProvider.notifier).pickImagefromCamera();
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: AppColors.whiteColor,
                  ),
                  label: textSize12(
                    text: "Open Camera",
                    color: AppColors.textPrimaryColor,
                  ),
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
                  onPressed: () async {
                    await ref
                        .read(scanProvider.notifier)
                        .pickImagefromGallery();
                  },
                  icon: const Icon(
                    Icons.upload,
                    color: AppColors.whiteColor,
                  ),
                  label: textSize12(
                    text: "Upload Image",
                    color: AppColors.textPrimaryColor,
                  ),
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
