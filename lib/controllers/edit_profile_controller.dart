import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileProvider = StateNotifierProvider.autoDispose<
    EditProfileController, AsyncValue<UserData>>((ref) {
  return EditProfileController();
});

class EditProfileController extends StateNotifier<AsyncValue<UserData>> {
  EditProfileController() : super(const AsyncValue.loading()) {
    _fetchEditProfileData();
  }
  UserData? _profileData;

  Future<void> _fetchEditProfileData() async {
    if (_profileData != null) {
      print('Loading data from local cache');
      state = AsyncValue.data(_profileData!);
      return;
    }
    print('Fetching data from Firestore');
    try {
      final userId = FirebaseAuth.instance.currentUser;
      if (userId == null) {
        throw Exception('No user is currently signed in');
      }

      final firebase = FirebaseFirestore.instance;
      final DocumentSnapshot documentSnapshot =
          await firebase.collection("user").doc(userId.uid).get();

      if (!documentSnapshot.exists) {
        throw Exception('User does not exist');
      }
      _profileData = UserData.fromFirestore(documentSnapshot);
      print('Data fetched from Firestore');
      state = AsyncValue.data(_profileData!);
    } catch (error, stackTrace) {
     if (mounted) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }

  Future<void> updateProfile(UserData user) async {
    print('Updating profile with new data');

    try {
      final firebase = FirebaseFirestore.instance;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await firebase.collection("user").doc(userId).set({
        'firstname': user.firstName,
        'lastname': user.lastName,
        'email': user.email,
        'profileImage': user.imgURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _profileData = user;
      print('update data from local cache');
      state = AsyncValue.data(_profileData!);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

class UserData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? imgURL;

  UserData({this.id, this.firstName, this.lastName, this.email, this.imgURL});

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserData(
      id: doc.id,
      firstName: data['firstname'] ?? '',
      lastName: data['lastname'] ?? '',
      email: data['email'] ?? '',
      imgURL: data['profileImage'] ?? '',
    );
  }
}
