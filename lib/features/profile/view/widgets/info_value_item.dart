import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';

class InfoValueItem extends StatelessWidget {
  final String? label;
  final String? value;
  const InfoValueItem({super.key, this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Alexandria',
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryHeadTextColor.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 7.h),
          Container(
            margin: EdgeInsets.only(top: 4.h),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            constraints: BoxConstraints(
              minHeight: 50.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Color(0xff6B7280).withOpacity(0.3), width: 1.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              value ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Alexandria',
                color: AppColors.secondaryHeadTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
