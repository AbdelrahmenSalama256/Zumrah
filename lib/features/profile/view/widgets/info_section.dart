import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';

class InfoSection extends StatelessWidget {
  final String? sectionTitle;
  final IconData? sectionIcon;
  final List<Widget>? children;
  const InfoSection({
    super.key,
    this.sectionTitle,
    this.sectionIcon,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          margin: EdgeInsets.only(bottom: 20.h),
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (sectionIcon != null) ...[
                    Icon(
                      sectionIcon,
                      size: 20.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  if (sectionTitle != null) ...[
                    Text(
                      sectionTitle!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryHeadTextColor,
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 12.h),
              ...?children,
//it will be list of items
            ],
          ),
        ),
      ),
    );
  }
}
