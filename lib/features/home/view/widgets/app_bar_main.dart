import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/navigation.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final String? title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBackTap;

  const AppBarMain(
      {super.key,
      this.isHome = false,
      this.title,
      this.onMenuTap,
      this.onBackTap});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 100.w,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: 20.w),
        child: isHome
            ? SvgPicture.asset(
                "assets/images/svg/logo.svg",
                width: 40.w,
                height: 40.h,
              )
            : GestureDetector(
                onTap: onBackTap ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 16.w),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.8),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF2EADE0).withOpacity(0.1),
                                  offset: const Offset(0, 4),
                                  blurRadius: 6,
                                  spreadRadius: -4,
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xFF2EADE0).withOpacity(0.1),
                                  offset: const Offset(0, 10),
                                  blurRadius: 15,
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/images/svg/back_arrow.svg',
                              color: AppColors.g1,
                              // height: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 16.w),
          child: Builder(
            builder: (innerContext) {
              return GestureDetector(
                onTap: onMenuTap ??
                    () {
                      drawerKey.currentState?.openDrawer();
                    },
                child: Row(
                  children: [
                    ClipRRect(
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
                                color: const Color(0xFF2EADE0).withOpacity(0.1),
                                offset: const Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: -4,
                              ),
                              BoxShadow(
                                color: const Color(0xFF2EADE0).withOpacity(0.1),
                                offset: const Offset(0, 10),
                                blurRadius: 15,
                                spreadRadius: -3,
                              ),
                            ],
                          ),
                          child: Icon(Icons.menu,
                              color: AppColors.g1, size: 24.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      centerTitle: true,
      title: !isHome && title != null
          ? Text(
              title!,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Alexandria',
              ),
            )
          : null,
    );
  }
}
