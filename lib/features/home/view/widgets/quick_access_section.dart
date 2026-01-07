import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/locale/app_loacl.dart';

import 'home_services_card.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          "home_quick_access_title".tr(context),
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.secondaryColor,
            fontFamily: 'Alexandria',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 300.h,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.2,
            children: [
              HomeServicesCard(
                icon: Iconsax.home,
                title: "home_service_reports_title".tr(context),
                subtitle: "home_service_reports_subtitle".tr(context),
                onTap: () {
                  debugPrint('Reports tapped');
                },
              ),
              HomeServicesCard(
                icon: Icons.groups_outlined,
                iconColor: const Color(0xff9333EA),
                title: "home_service_team_title".tr(context),
                subtitle: "home_service_team_subtitle".tr(context),
                onTap: () {
                  debugPrint('Team tapped');
                },
              ),
              HomeServicesCard(
                icon: Iconsax.chart_21,
                title: "home_service_analytics_title".tr(context),
                iconColor: const Color(0xffEA580C),
                subtitle: "home_service_analytics_subtitle".tr(context),
                onTap: () {
                  debugPrint('Analytics tapped');
                },
              ),
              HomeServicesCard(
                icon: Iconsax.setting_2,
                iconColor: const Color(0xff4B5563),
                title: "home_service_settings_title".tr(context),
                subtitle: "home_service_settings_subtitle".tr(context),
                onTap: () {
                  debugPrint('Settings tapped');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
