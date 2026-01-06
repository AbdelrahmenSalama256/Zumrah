import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';

class HomeServicesCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const HomeServicesCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), // blur 16px
          child: Container(
            width: 160.44.w,
            height: 125.h,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withOpacity(1),
                width: 2.w,
              ),
              color: Colors.white.withOpacity(0.6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), // خففته عشان يشبه 0D
                  blurRadius: 30.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  // padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: iconColor?.withOpacity(0.1) ??
                        AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: iconColor?.withOpacity(0.1) ??
                            AppColors.primaryColor.withOpacity(0.1),
                        blurRadius: 2.r,
                        offset: Offset(0, 1.h),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      size: 30.sp,
                      color: iconColor ?? Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryHeadTextColor,
                    fontFamily: 'Alexandria',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryHeadTextColor.withOpacity(0.7),
                    fontFamily: 'Alexandria',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
