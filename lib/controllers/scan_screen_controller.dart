import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final scanProvider =
    StateNotifierProvider<ScanScreenController, AsyncValue<File?>>(
        (ref) => ScanScreenController());

class ScanScreenController extends StateNotifier<AsyncValue<File>> {
  ScanScreenController() : super(const AsyncValue.loading());

  final ImagePicker? imgPicker = ImagePicker();
  Future<void> pickImagefromCamera() async {
    try {
      final pickedFile = await imgPicker!.pickImage(source: ImageSource.camera);
      if (imgPicker != null) {
        state = AsyncValue.data(File(pickedFile!.path));
      } else {
        state = const AsyncValue.error("No image selected", StackTrace.empty);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> pickImagefromGallery() async {
    try {
      final pickedFile =
          await imgPicker!.pickImage(source: ImageSource.gallery);
      if (imgPicker != null) {
        state = AsyncValue.data(File(pickedFile!.path));
      } else {
        state = const AsyncValue.error("No image selected", StackTrace.empty);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
