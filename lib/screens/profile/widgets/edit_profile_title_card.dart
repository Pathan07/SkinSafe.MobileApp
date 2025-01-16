import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class EditProfileTitleCard extends StatelessWidget {
  final String? imagURL;

  const EditProfileTitleCard({super.key, required this.imagURL});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: AppColors.logoColor,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  imagURL!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 18,
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blackColor,
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    size: 15,
                    color: AppColors.whiteColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
