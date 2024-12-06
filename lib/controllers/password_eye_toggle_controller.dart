import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier for managing password visibility
class PasswordVisibilityNotifier extends StateNotifier<bool> {
  PasswordVisibilityNotifier() : super(true); // Initially, the password is hidden

  void toggle() {
    state = !state; // Toggle the password visibility state
  }
}

// Provider for the PasswordVisibilityNotifier
final passwordVisibilityProvider = StateNotifierProvider<PasswordVisibilityNotifier, bool>(
  (ref) => PasswordVisibilityNotifier(),
);
