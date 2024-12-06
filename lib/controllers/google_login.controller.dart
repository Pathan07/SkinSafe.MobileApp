import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { initial, loading, authenticated, error }
final googleLoginProvider =
    StateNotifierProvider<GoogleLoginStateNotifier, AuthState>(
  (ref) => GoogleLoginStateNotifier(),
);

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? error;

  AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
  });

  AuthState copyWith({AuthStatus? status, User? user, String? error}) {
    return AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        error: error ?? this.error);
  }
}


class GoogleLoginStateNotifier extends StateNotifier<AuthState> {
  GoogleLoginStateNotifier() : super(AuthState());

  Future<void> signInWithGoogle() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        state = state.copyWith(
            status: AuthStatus.error, error: 'Google Sign-In failed');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("user")
            .doc(user.uid)
            .get();
        final String? firstName = googleUser.displayName?.split(' ').first;
        final String? lastName = googleUser.displayName?.split(' ').last;
        final String profileImage = googleUser.photoUrl ??
            'https://www.gstatic.com/images/branding/product/1x/avatar_square_blue_512dp.png';

        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection("user")
              .doc(user.uid)
              .set({
            'firstname': firstName,
            'lastname': lastName,
            'createdAt': FieldValue.serverTimestamp(),
            'email': user.email,
            'profileImage': profileImage,
          });
        }

        state = state.copyWith(status: AuthStatus.authenticated, user: user);
      }
    } catch (e) {
      state = state.copyWith(
          status: AuthStatus.error, error: 'Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    state = state.copyWith(status: AuthStatus.initial, user: null, error: null);
  }
}
