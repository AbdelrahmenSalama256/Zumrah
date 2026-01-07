import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/locale/app_loacl.dart';

class AchievementBanner extends StatelessWidget {
  const AchievementBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset("assets/images/png/slide.png", fit: BoxFit.cover),
        )),
        Container(
          width: double.infinity,
          height: 150.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.8),
              width: 1.6.w,
            ),
            color: Colors.white.withOpacity(0.8), // خليها 0 عشان الخلفية واضحة
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "home_banner_update_label".tr(context),
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Alexandria',
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "home_banner_summary_title".tr(context),
                style: TextStyle(
                  color: AppColors.secondaryHeadTextColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Alexandria',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "home_banner_summary_text".tr(context),
                style: TextStyle(
                  color: const Color(0xff5A7080),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Alexandria',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
