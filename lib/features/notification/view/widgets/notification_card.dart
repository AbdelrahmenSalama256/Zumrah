import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String desc;
  final String time;
  final String type;
  final bool? isunread;
  final VoidCallback? onTap;
  final IconData? icon;
  const NotificationCard(
      {super.key,
      required this.title,
      required this.desc,
      required this.time,
      required this.type,
      this.onTap,
      this.isunread,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        icon ?? Iconsax.document_text,
                        size: 25.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    // if unread indicator and color changes based on notification type
                    if (isunread!) ...[
                      Positioned(
                        child: Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: type == 'task'
                                ? AppColors.primaryColor
                                : type == "daily"
                                    ? AppColors.secondaryHeadTextColor
                                    : type == "important"
                                        ? AppColors.red
                                        : AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                SizedBox(width: 10.w),
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
                            title,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12.sp,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Alexandria',
                            ),
                          ),

                          // since "time as text not math"
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            child: Text(
                              time,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Alexandria',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        desc,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Alexandria',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.sp,
                    color: AppColors.secondaryHeadTextColor.withOpacity(0.5),
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
