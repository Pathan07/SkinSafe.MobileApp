import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class AvatarSelectionSheet extends StatelessWidget {
  final Function(String) onAvatarSelected;

  const AvatarSelectionSheet({
    Key? key,
    required this.onAvatarSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of predefined avatar paths
    final List<String> avatarPaths = [
      'assets/avatars/avatar1.svg',
      'assets/avatars/avatar2.svg',
      'assets/avatars/avatar3.svg',
      'assets/avatars/avatar4.svg',
      'assets/avatars/avatar5.svg',
      'assets/avatars/avatar6.svg',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textSize20(text: 'Select Avatar'),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: avatarPaths.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onAvatarSelected(avatarPaths[index]);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blackColor.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      avatarPaths[index],
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}