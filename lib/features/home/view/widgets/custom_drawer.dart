import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _navigate(BuildContext context, int index) {
    context.read<GlobalCubit>().changeBottomNavIndex(index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<GlobalCubit>().currentNavIndex;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
              child: Image.asset(
                'assets/images/png/logo1--top.png',
                fit: BoxFit.contain,
              ),
            ),
            _DrawerItem(
              icon: Iconsax.home,
              label: 'Home',
              isSelected: selectedIndex == 0,
              onTap: () => _navigate(context, 0),
            ),
            _DrawerItem(
              icon: Iconsax.search_normal,
              label: 'Search',
              isSelected: selectedIndex == 1,
              onTap: () => _navigate(context, 1),
            ),
            _DrawerItem(
              icon: Iconsax.heart,
              label: 'Favorites',
              isSelected: selectedIndex == 2,
              onTap: () => _navigate(context, 2),
            ),
            _DrawerItem(
              icon: Iconsax.user,
              label: 'Profile',
              isSelected: selectedIndex == 3,
              onTap: () => _navigate(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primaryColor : Colors.grey[700],
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primaryColor : Colors.black,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      onTap: onTap,
    );
  }
}
