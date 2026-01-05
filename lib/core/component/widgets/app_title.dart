import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/locale/app_loacl.dart';

//! SectionHeader with Gradient Title
class SectionHeader extends StatelessWidget {
  final String titleKey;
  final String? subtitleKey;
  final bool showSeeAll;
  final String? seeAllTextKey;
  final double? fontSize;
  final VoidCallback? onSeeAllTap;
  final CrossAxisAlignment? crossAxisAlignment;

  const SectionHeader({
    super.key,
    required this.titleKey,
    this.subtitleKey,
    this.showSeeAll = true,
    this.seeAllTextKey,
    this.onSeeAllTap,
    this.crossAxisAlignment,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final String title = titleKey.tr(context); // Translate first

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            children: [
              // Gradient Title using ShaderMask
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColors.g1, AppColors.g2],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              if (subtitleKey != null && subtitleKey!.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitleKey!.tr(context),
                  textAlign: crossAxisAlignment == CrossAxisAlignment.center
                      ? TextAlign.center
                      : TextAlign.start,
                  style: TextStyle(
                    fontSize: fontSize ?? 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Alexandria',
                    color: AppColors.subTextColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (showSeeAll && onSeeAllTap != null)
          TextButton(
            onPressed: onSeeAllTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50.w, 30.h),
              alignment: Alignment.centerRight,
            ),
            child: Text(
              seeAllTextKey ?? 'see_all_button'.tr(context),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryLight,
              ),
            ),
          ),
      ],
    );
  }
}
