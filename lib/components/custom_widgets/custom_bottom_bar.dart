import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/utilities/color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentTab;
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.blackColor,
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              NavBarItem(
                icon: Icons.home,
                label: 'Home',
                isSelected: currentTab == 0,
                onTap: () => onTabSelected(0),
              ),
              NavBarItem(
                icon: Icons.qr_code_scanner,
                label: 'Skin Scan',
                isSelected: currentTab == 1,
                onTap: () => onTabSelected(1),
              ),
              const SizedBox(width: 20),
              NavBarItem(
                icon: Icons.history,
                label: 'History',
                isSelected: currentTab == 3,
                onTap: () => onTabSelected(3),
              ),
              NavBarItem(
                icon: Icons.person,
                label: 'Profile',
                isSelected: currentTab == 4,
                onTap: () => onTabSelected(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.ratingColor : AppColors.whiteColor,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.ratingColor : AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
