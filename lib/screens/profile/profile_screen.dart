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
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(editProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: textSize20(text: 'Edit Profile'),
        centerTitle: true,
      ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: EditProfileTitleCard(
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
                          email: emailController.text);
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
