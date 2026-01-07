import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/home/view/widgets/app_bar_main.dart';

import 'widgets/achievement_banner.dart';
// Widgets
import 'widgets/profile_header.dart';
import 'widgets/quick_access_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool trackingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarMain(
        isHome: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                name: "home_profile_name".tr(context),
                role: "home_profile_role".tr(context),
                trackingEnabled: trackingEnabled,
                onTrackingChanged: (value) {
                  setState(() {
                    trackingEnabled = value;
                  });
                },
              ),
              QuickAccessSection(),
              // SizedBox(height: 20.h),
              AchievementBanner(),
              // SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
