import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/navigation.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/notification/view/notifications_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _closeDrawerThen(BuildContext context, VoidCallback action) {
    WidgetsBinding.instance.addPostFrameCallback((_) => action());
    Navigator.of(context).pop();
  }

  void _navigate(BuildContext context, int index) {
    _closeDrawerThen(
      context,
      () => context.read<GlobalCubit>().changeBottomNavIndex(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<GlobalCubit>().currentNavIndex;

    return Drawer(
      surfaceTintColor: Colors.transparent,
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
                        "main_menu_title".tr(context),
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
                    icon: Iconsax.setting_2,
                    label: 'settings'.tr(context),
                    isSelected: selectedIndex == 0,
                    onTap: () => _navigate(context, 0),
                  ),
                  _DrawerItem(
                    icon: Iconsax.document,
                    label: 'daily_tasks'.tr(context),
                    isSelected: selectedIndex == 1,
                    onTap: () => _navigate(context, 1),
                  ),
                  _DrawerItem(
                    icon: Iconsax.language_circle,
                    label: 'language'.tr(context),
                    isSelected: selectedIndex == 2,
                    onTap: () => _navigate(context, 2),
                  ),
                  _DrawerItem(
                    icon: Iconsax.notification,
                    label: 'notifications'.tr(context),
                    isSelected: selectedIndex == 3,
                    onTap: () => _closeDrawerThen(
                      context,
                      () => navigateTo(context, const NotificationsScreen()),
                    ),
                  ),
                  _DrawerItem(
                    icon: Iconsax.support,
                    label: 'technical_support'.tr(context),
                    isSelected: selectedIndex == 4,
                    onTap: () => _navigate(context, 4),
                  ),
                  _DrawerItem(
                    icon: Iconsax.info_circle,
                    label: 'about_app'.tr(context),
                    isSelected: selectedIndex == 5,
                    onTap: () => _navigate(context, 5),
                  ),
                  _DrawerItem(
                    icon: Iconsax.document_text,
                    label: 'terms_conditions'.tr(context),
                    isSelected: selectedIndex == 6,
                    onTap: () => _navigate(context, 6),
                  ),
                  _DrawerItem(
                    icon: Iconsax.logout,
                    label: 'logout'.tr(context),
                    isSelected: false,
                    isLogout: true,
                    onTap: () {},
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
  final bool? isLogout;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.isLogout = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 56.h,
        ),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: !isLogout!
              ? LinearGradient(
                  colors: [
                    AppColors.g1,
                    AppColors.g2,
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                )
              : LinearGradient(
                  colors: [
                    Color(0xffEF4444).withOpacity(0.70),
                    Color(0xffEF4444).withOpacity(0.20),
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
            mainAxisAlignment:
                !isLogout! ? MainAxisAlignment.start : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isLogout!) ...[
                SizedBox(width: 12.w),
                Icon(icon,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.secondaryHeadTextColor.withOpacity(0.5),
                    size: 20.sp),
                SizedBox(width: 16.w),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: !isLogout!
                      ? AppColors.secondaryHeadTextColor.withOpacity(0.5)
                      : Color(0xff5A7080).withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Alexandria',
                ),
              ),
              if (isLogout!) ...[
                SizedBox(width: 12.w),
                Icon(icon, color: Color(0xff5A7080), size: 20.sp),
              ],
              if (!isLogout!) ...[
                Spacer(),
                Icon(Icons.arrow_forward_ios,
                    color: AppColors.secondaryHeadTextColor.withOpacity(0.5),
                    size: 15.sp),
                SizedBox(width: 12.w),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
