import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_buttons.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/controllers/edit_profile_controller.dart';
import 'package:skin_safe_app/screens/profile/widgets/edit_profile_title_card.dart';
import 'package:skin_safe_app/screens/profile/widgets/profile_textfeilds.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  // Function to select and update avatar
  Future<void> _selectAvatar(BuildContext context, WidgetRef ref, String userId) async {
  try {
    // Fetch avatars from Firestore
    final avatarsSnapshot = await FirebaseFirestore.instance.collection('avatars').get();
    final avatars = avatarsSnapshot.docs.map((doc) => doc['avatarUrl'] as String).toList();

    if (avatars.isEmpty) return;

    // Show avatar selection dialog
    final selectedAvatar = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: textSize20(text: "Select an Avatar"),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, avatars[index]); // Close dialog & return avatar
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(avatars[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedAvatar != null) {
      // Fetch the current user data
      final userDoc = await FirebaseFirestore.instance.collection('user').doc(userId).get();
      final userData = userDoc.data();

      // Update Firestore with selected avatar and existing fields
      await FirebaseFirestore.instance.collection('user').doc(userId).update({
        "profileImage": selectedAvatar,
        "firstname": userData?['firstname'],
        "lastname": userData?['lastname'],
        "email": userData?['email'],
      });

      // Update local provider state (so UI updates instantly)
      ref.read(editProfileProvider.notifier).updateProfile(UserData(
        imgURL: selectedAvatar,
        firstName: userData?['firstname'],
        lastName: userData?['lastname'],
        email: userData?['email'],
      ));
    }
  } catch (e) {
    print("Error fetching avatars: $e");
  }
}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(editProfileProvider);
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: textSize20(text: 'Edit Profile'),
        centerTitle: true,
      ),
      endDrawer: customDrawer(context: context),
      body: profileData.when(
        data: (data) {
          final firstNameController =
              TextEditingController(text: data.firstName ?? 'No first name');
          final lastNameController =
              TextEditingController(text: data.lastName ?? 'No last name');
          final emailController =
              TextEditingController(text: data.email ?? 'abc123@gmail.com');
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: EditProfileTitleCard(
                    onTap: () => _selectAvatar(context, ref, userId),
                    imagURL: data.imgURL ??
                        'https://www.gstatic.com/images/branding/product/1x/avatar_square_blue_512dp.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ProfileTextFields(
                      name: "First Name",
                      controller: firstNameController,
                      isReadAble: false),
                ),
                ProfileTextFields(
                    name: "Last Name",
                    controller: lastNameController,
                    isReadAble: false),
                ProfileTextFields(
                    name: "Email Address",
                    controller: emailController,
                    isReadAble: true),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: customButton(
                    textColor: AppColors.textPrimaryColor,
                    backgroundColor: AppColors.blackColor,
                    text: "Update Profile",
                    onTap: () {
                      final updatedProfile = UserData(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        imgURL: data.imgURL,
                        email: emailController.text,
                      );
                      ref
                          .read(editProfileProvider.notifier)
                          .updateProfile(updatedProfile);
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.blackColor)),
        error: (error, stackTrace) => Center(
          child: textSize18(
              text: "Something went wrong",
              color: AppColors.textSeconderyColor),
        ),
      ),
    );
  }
}
