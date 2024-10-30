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
            height: 170,
            width: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: AppColors.whiteColor,
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
            right: 20,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blackColor,
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: AppColors.whiteColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
