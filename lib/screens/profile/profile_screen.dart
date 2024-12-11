import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_app_bar.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_drawer.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/controllers/edit_profile_controller.dart';
import 'package:skin_safe_app/screens/profile/edit_profile_title_card.dart';

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
          final firstNameController = TextEditingController(
            text: data.firstName ?? 'No first name',
          );
          final lastNameController = TextEditingController(
            text: data.lastName ?? 'No last name',
          );
          final emailController = TextEditingController(
            text: data.email ?? 'abc123@gmail.com',
          );
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
                    isReadAble: false,
                  ),
                ),
                ProfileTextFields(
                  name: "Last Name",
                  controller: lastNameController,
                  isReadAble: false,
                ),
                ProfileTextFields(
                  name: "Email Address",
                  controller: emailController,
                  isReadAble: true,
                ),
                const SizedBox(height: 20),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blackColor,
                      ),
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
                        text: "Update Profile",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.whiteColor)),
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

class ProfileTextFields extends StatelessWidget {
  final String? name;
  final TextEditingController? controller;
  final bool? isReadAble;

  const ProfileTextFields({
    super.key,
    this.name,
    this.controller,
    this.isReadAble,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textSize16(
              color: AppColors.textPrimaryColor,
              text: name!,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                width: 2,
                color: AppColors.blackColor.withOpacity(0.2),
              ),
            ),
            child: TextField(
              controller: controller,
              readOnly: isReadAble!,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
