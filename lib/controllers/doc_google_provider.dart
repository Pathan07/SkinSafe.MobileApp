import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DocAuthStatus { initial, loading, authenticated, error }

final docGoogleLoginProvider =
    StateNotifierProvider<GoogleLoginStateNotifier, DocAuthState>(
  (ref) => GoogleLoginStateNotifier(),
);

class DocAuthState {
  final DocAuthStatus status;
  final User? user;
  final String? error;

  DocAuthState({
    this.status = DocAuthStatus.initial,
    this.user,
    this.error,
  });

  DocAuthState copyWith({DocAuthStatus? status, User? user, String? error}) {
    return DocAuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        error: error ?? this.error);
  }
}

class GoogleLoginStateNotifier extends StateNotifier<DocAuthState> {
  GoogleLoginStateNotifier() : super(DocAuthState());

  Future<void> signInWithGoogle() async {
    try {
      state = state.copyWith(status: DocAuthStatus.loading);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        state = state.copyWith(
            status: DocAuthStatus.error, error: 'Google Sign-In failed');
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
        // Check if user exists in doctors collection
        final DocumentSnapshot doctorDoc = await FirebaseFirestore.instance
            .collection("doctors")
            .doc(user.uid)
            .get();

        final String? firstName = googleUser.displayName?.split(' ').first;
        final String? lastName = googleUser.displayName?.split(' ').last;
        final String profileImage = googleUser.photoUrl ??
            'https://www.gstatic.com/images/branding/product/1x/avatar_square_blue_512dp.png';

        if (!doctorDoc.exists) {
          await FirebaseFirestore.instance
              .collection("doctors")
              .doc(user.uid)
              .set({
            'firstname': firstName,
            'lastname': lastName,
            'createdAt': FieldValue.serverTimestamp(),
            'email': user.email,
            'profileImage': profileImage,
            'uid': user.uid,
          });
        }

        state = state.copyWith(status: DocAuthStatus.authenticated, user: user);
      }
    } catch (e) {
      state = state.copyWith(
          status: DocAuthStatus.error,
          error: 'Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    state =
        state.copyWith(status: DocAuthStatus.initial, user: null, error: null);
  }
}
