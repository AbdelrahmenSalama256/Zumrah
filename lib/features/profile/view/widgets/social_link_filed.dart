// features/profile/view/widgets/social_link_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';

import '../../../../core/component/widgets/app_text_field.dart';

class SocialLinkField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const SocialLinkField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xff6B7280).withOpacity(0.3),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 51.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20.r),
                  bottomStart: Radius.circular(20.r),
                ),
              ),
              child: Icon(
                Iconsax.link,
                size: 24.sp,
                color: AppColors.white,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppTextField(
                hintStyle: TextStyle(
                  color: const Color(0xff6B7280).withOpacity(0.5),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Alexandria',
                ),
                controller: controller ?? TextEditingController(),
                onChanged: onChanged,
                hintText: hintText,
                inputBorderColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
