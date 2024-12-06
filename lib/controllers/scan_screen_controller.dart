import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final scanProvider =
    StateNotifierProvider<ScanScreenController, AsyncValue<File?>>(
        (ref) => ScanScreenController());

class ScanScreenController extends StateNotifier<AsyncValue<File?>> {
  ScanScreenController() : super(const AsyncValue.data(null)); // Start with no image

  final ImagePicker imgPicker = ImagePicker(); 

  Future<void> pickImagefromCamera() async {
    // state = const AsyncValue.loading(); // Set loading state

    try {
      final pickedFile = await imgPicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        state = AsyncValue.data(File(pickedFile.path)); // Set the picked image
      } else {
        state = const AsyncValue.data(null); // No image selected
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace); // Handle any errors
    }
  }

  Future<void> pickImagefromGallery() async {
    // state = const AsyncValue.loading(); // Set loading state

    try {
      final pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        state = AsyncValue.data(File(pickedFile.path)); // Set the picked image
      } else {
        state = const AsyncValue.data(null); // No image selected
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace); // Handle any errors
    }
  }
}
