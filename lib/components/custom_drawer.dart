import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

Widget customDrawer({required BuildContext context}) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          curve: Curves.bounceIn,
          child: Column(
            children: [
              textSize30(text: "Skin Safe", color: AppColors.textPrimaryColor),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.whiteColor,
                  child: Icon(Icons.person),
                ),
                title: Text(
                  "Welcome Buddy!",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.textPrimaryColor),
                ),
                subtitle: Text(
                  "abc123@gmail.com",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.textPrimaryColor),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
            color: AppColors.primaryColor,
          ),
          title: textSize16(text: "Home", fontWeight: FontWeight.normal),
          onTap: (){
            Navigator.pushNamed(context, RouteName.homeScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.camera_alt,
            color: AppColors.primaryColor,
          ),
          title: textSize16(text: "Scan", fontWeight: FontWeight.normal),
          onTap: (){
            Navigator.pushNamed(context, RouteName.scanScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.history,
            color: AppColors.primaryColor,
          ),
          title: textSize16(text: "History", fontWeight: FontWeight.normal),
          onTap: (){
            Navigator.pushNamed(context, RouteName.historyScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.school,
            color: AppColors.primaryColor,
          ),
          title: textSize16(text: "Education", fontWeight: FontWeight.normal),
          onTap: (){
            Navigator.pushNamed(context, RouteName.educationScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: AppColors.primaryColor,
          ),
          title: textSize16(text: "Profile", fontWeight: FontWeight.normal),
          onTap: (){
            Navigator.pushNamed(context, RouteName.profileScreen);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.info,
            color: AppColors.primaryColor,
          ),
          title: textSize16(text: "About", fontWeight: FontWeight.normal),
          onTap: (){
            Navigator.pushNamed(context, RouteName.aboutScreen);
          },
        ),
      ],
    ),
  );
}
