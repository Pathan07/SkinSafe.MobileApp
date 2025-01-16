import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/controllers/edit_profile_controller.dart';
import 'package:skin_safe_app/controllers/google_login.controller.dart';

Widget customDrawer({required BuildContext context}) {
  return Drawer(
    child: Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            final profileData = ref.watch(editProfileProvider);
            return DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.logoColor),
              curve: Curves.bounceIn,
              child: profileData.when(
                data: (data) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundColor: AppColors.blackColor,
                        backgroundImage: NetworkImage(
                          data.imgURL ??
                              'https://www.gstatic.com/images/branding/product/1x/avatar_square_blue_512dp.png',
                        )),
                    title: Text(
                      "${data.firstName} ${data.lastName}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textPrimaryColor),
                    ),
                    subtitle: Text(
                      data.email!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textPrimaryColor),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: textSize18(text: "Something went wrong"),
                  );
                },
                loading: () => const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                )),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: AppColors.logoColor,
          ),
          title: textSize16(text: "Profile", fontWeight: FontWeight.normal),
          onTap: () {
            Navigator.pushNamed(context, RouteName.profileScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.school,
            color: AppColors.logoColor,
          ),
          title: textSize16(text: "Education", fontWeight: FontWeight.normal),
          onTap: () {
            Navigator.pushNamed(context, RouteName.educationScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.info,
            color: AppColors.logoColor,
          ),
          title: textSize16(text: "About", fontWeight: FontWeight.normal),
          onTap: () {
            Navigator.pushNamed(context, RouteName.aboutScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.auto_awesome_sharp,
            color: AppColors.logoColor,
          ),
          title:
              textSize16(text: "Skin Safe Bot", fontWeight: FontWeight.normal),
          onTap: () {
            Navigator.pushNamed(context, RouteName.skinSafeBot);
          },
        ),
        signOut(),
      ],
    ),
  );
}

Widget signOut() {
  return Consumer(
    builder: (context, ref, child) {
      final User? user = FirebaseAuth.instance.currentUser;
      return ListTile(
        leading: const Icon(
          Icons.logout,
          color: AppColors.blackColor,
        ),
        title: const Text('Logout'),
        onTap: () async {
          print({user!.providerData});
          for (var userInfo in user.providerData) {
            switch (userInfo.providerId) {
              case 'google.com':
                await ref.read(googleLoginProvider.notifier).signOut();
                print('Signed out with Google');
                break;

              case 'password':
                await FirebaseAuth.instance.signOut();
                print('Signed out with Email/Password');
                break;

              default:
                print('Signed out with ${userInfo.providerId}');
                break;
            }
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.signupScreen,
            (route) => false,
          );
        },
      );
    },
  );
}
