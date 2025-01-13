import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/controllers/edit_profile_controller.dart';
import 'package:skin_safe_app/screens/profile/widgets/edit_profile_title_card.dart';
import 'package:skin_safe_app/screens/profile/widgets/profile_textfeilds.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(editProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.logoColor,
      appBar: customAppBar(title: 'Edit Profile'),
      endDrawer: customDrawer(
        context: context,
      ),
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
                EditProfileTitleCard(
                  imagURL: data.imgURL ??
                      'https://www.gstatic.com/images/branding/product/1x/avatar_square_blue_512dp.png',
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blackColor),
                      onPressed: () {
                        final updatedProfile = UserData(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            imgURL: data.imgURL,
                            email: emailController.text);
                        ref
                            .read(editProfileProvider.notifier)
                            .updateProfile(updatedProfile);
                      },
                      child: textSize20(
                          color: AppColors.textPrimaryColor,
                          text: "Update Profile"),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.whiteColor)),
        error: (error, stackTrace) => Center(
          child: Center(
              child: textSize18(
                  text: "Something went wrong",
                  color: AppColors.textSeconderyColor)),
        ),
      ),
    );
  }
}
