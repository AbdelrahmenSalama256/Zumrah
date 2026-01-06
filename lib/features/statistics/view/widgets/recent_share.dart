import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';

class RecentShare extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? type;
  final String? dateTime;
  final bool? isOnline;
  final String? avatarUrl;

  const RecentShare({
    super.key,
    this.title,
    this.subtitle,
    this.type,
    this.dateTime,
    this.isOnline = false,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), // blur 16px

        child: Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.all(0.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,

                          // borderRadius: BorderRadius.circular(12.r),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 2.r,
                              offset: Offset(0, 1.h),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          avatarUrl ??
                              'assets/images/png/avatar_placeholder.png',
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Iconsax.user,
                              size: 24.sp,
                              color: AppColors.g2,
                            );
                          },
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // online indicator
                      PositionedDirectional(
                        bottom: 0,
                        start: 0,
                        child: isOnline! == true
                            ? Container(
                                width: 14.w,
                                height: 14.w,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.w,
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              title ?? "اسم المستخدم",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondaryHeadTextColor,
                                fontFamily: 'Alexandria',
                              ),
                            ),
                            Text(
                              dateTime ?? "0:00 م",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryHeadTextColor
                                    .withOpacity(0.3),
                                fontFamily: 'Alexandria',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              subtitle ?? "وصف المشاركة",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryHeadTextColor,
                                fontFamily: 'Alexandria',
                              ),
                            ),
                            if (type == "link") ...[
                              Icon(
                                Iconsax.link,
                                size: 12.sp,
                                color: AppColors.secondaryHeadTextColor
                                    .withOpacity(0.7),
                              ),
                            ] else if (type == "save_contact") ...[
                              Icon(
                                Iconsax.arrow_down,
                                size: 12.sp,
                                color: AppColors.secondaryHeadTextColor
                                    .withOpacity(0.7),
                              ),
                            ] else if (type == "share_contact") ...[
                              Icon(
                                Iconsax.share,
                                size: 12.sp,
                                color: AppColors.secondaryHeadTextColor
                                    .withOpacity(0.7),
                              ),
                            ] else ...[
                              Icon(
                                Iconsax.eye,
                                size: 12.sp,
                                color: AppColors.secondaryHeadTextColor
                                    .withOpacity(0.7),
                              ),
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
