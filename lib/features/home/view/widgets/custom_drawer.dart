import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Image.asset(
                'assets/images/png/main.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "القائمة الرئيسية",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Alexandria',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.8),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2EADE0)
                                        .withOpacity(0.1),
                                    offset: const Offset(0, 4),
                                    blurRadius: 6,
                                    spreadRadius: -4,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF2EADE0)
                                        .withOpacity(0.1),
                                    offset: const Offset(0, 10),
                                    blurRadius: 15,
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: Icon(Icons.close_rounded,
                                  color: AppColors.g1, size: 24.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
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
          ),
        ],
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
    return Container(
      constraints: BoxConstraints(
        minHeight: 56.h,
      ),
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.all(1.5.w),
      decoration: BoxDecoration(
        // color: ,
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: [
            AppColors.g1,
            AppColors.g2,
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
              onPressed: onTap,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondaryHeadTextColor.withOpacity(0.5),
                fontWeight: FontWeight.w600,
                fontFamily: 'Alexandria',
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios,
                color: AppColors.secondaryHeadTextColor.withOpacity(0.5),
                size: 15.sp),
            SizedBox(width: 12.w),
          ],
        ),
      ),
    );
  }
}
