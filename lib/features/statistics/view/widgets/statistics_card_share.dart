import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';

class StatisticsCardShare extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? persentage;
  final IconData? icon;
  final Color? iconColor;
  final bool? isIconImage;
  final String? iconImage;

  const StatisticsCardShare({
    super.key,
    required this.title,
    required this.subtitle,
    this.persentage,
    this.icon,
    this.iconColor,
    this.isIconImage,
    this.iconImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), // blur 16px
        child: Container(
          width: 160.44.w,
          height: 158.h,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    // padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.white.withOpacity(0.6),
                          blurRadius: 2.r,
                          offset: Offset(0, 1.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: isIconImage == true
                          ? Icon(
                              icon,
                              size: 24.sp,
                              color: iconColor ?? AppColors.primaryColor,
                            )
                          : SvgPicture.asset(
                              "$iconImage",
                              width: 24.w,
                              height: 24.h,
                              color: iconColor ?? AppColors.primaryColor,
                            ),
                    ),
                  ),
                  if (persentage != null) ...[
                    SizedBox(width: 6.w),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          size: 12.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '$persentage %',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryHeadTextColor
                                .withOpacity(0.7),
                            fontFamily: 'Alexandria',
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryHeadTextColor,
                  fontFamily: 'Alexandria',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryHeadTextColor.withOpacity(0.7),
                  fontFamily: 'Alexandria',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
