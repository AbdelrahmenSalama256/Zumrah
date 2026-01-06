// features/profile/view/widgets/social_link_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zumrah/core/constants/app_colors.dart';

class SocialLinkItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String url;
  final String? iconImage;

  const SocialLinkItem({
    super.key,
    this.icon,
    required this.label,
    required this.url,
    this.iconImage,
  });

  Future<void> _launchUrl() async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // يمكنك إضافة snackbar هنا إذا أردت
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchUrl,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 48.w,
        height: 48.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        constraints: BoxConstraints(minHeight: 50.h),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: iconImage == null
            ? Icon(
                icon,
                size: 24.sp,
                color: AppColors.primaryColor,
              )
            : SvgPicture.asset(
                iconImage!,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
