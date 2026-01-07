import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/home/view/widgets/app_bar_main.dart';
import 'package:zumrah/features/statistics/view/widgets/recent_share.dart';
import 'package:zumrah/features/statistics/view/widgets/statistics_card_share.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarMain(
        title: "statistics_title".tr(context),
        onBackTap: () {
          context.read<GlobalCubit>().changeBottomNavIndex(0);
        },
        onMenuTap: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    margin: EdgeInsetsDirectional.only(top: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2EADE0).withOpacity(0.1),
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: -4,
                        ),
                        BoxShadow(
                          color: const Color(0xFF2EADE0).withOpacity(0.1),
                          offset: const Offset(0, 10),
                          blurRadius: 15,
                          spreadRadius: -3,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "statistics_profile_visits".tr(context),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Alexandria',
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  '3,482',
                                  style: TextStyle(
                                    fontSize: 36.sp,
                                    fontFamily: 'Alexandria',
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/svg/statistics_arrow.svg"),
                                SizedBox(width: 5.w),
                                Text(
                                  '12%',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Alexandria',
                                    color: AppColors.secondaryHeadTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "statistics_this_week_vs_last".tr(context),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Alexandria',
                            color: AppColors.secondaryColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // Add charts for statistics
                        SizedBox(height: 16.h),
                        // Line Chart
                        SizedBox(
                          height: 150.h,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 32,
                                    getTitlesWidget: (value, meta) {
                                      final days = [
                                        "day_sat".tr(context),
                                        "day_sun".tr(context),
                                        "day_mon".tr(context),
                                        "day_tue".tr(context),
                                        "day_wed".tr(context),
                                        "day_thu".tr(context),
                                        "day_fri".tr(context),
                                      ];
                                      int index = value.toInt();
                                      if (index >= 0 && index < days.length) {
                                        return Text(
                                          days[index],
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Alexandria',
                                            color: AppColors.secondaryColor
                                                .withOpacity(0.40),
                                          ),
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(show: false),
                              minX: 0,
                              maxX: 6,
                              minY: 0,
                              maxY: 6,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(0, 1),
                                    FlSpot(1, 2.5),
                                    FlSpot(2, 2),
                                    FlSpot(3, 3),
                                    FlSpot(4, 3.5),
                                    FlSpot(5, 3.8),
                                    FlSpot(6, 5),
                                  ],
                                  isCurved: true,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2EADED),
                                      Color(0xFF65DFE6)
                                    ],
                                  ),
                                  barWidth: 3,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: true,
                                    // dotColor: Colors.white,
                                    // dotSize: 4,
                                    // strokeWidth: 2,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0x4D2EADED), // 30% opacity
                                        const Color(0x002EADED), // 0 opacity
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              // Gridview of Statistics sharding cards two in a row
              Wrap(
                spacing: 16.w,
                runSpacing: 16.h,
                children: [
                  StatisticsCardShare(
                    title: "450",
                    subtitle: "statistics_via_qr".tr(context),
                    iconImage: "assets/images/svg/qr.svg",
                    persentage: "5",
                  ),
                  StatisticsCardShare(
                    title: "120",
                    subtitle: "statistics_via_nfc".tr(context),
                    iconImage: "assets/images/svg/share_nfc.svg",
                    persentage: "2",
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "last_interactions".tr(context),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Alexandria',
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle view all tap
                    },
                    child: Text(
                      "see_all_button".tr(context),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Alexandria',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              // List of recent activities
              SizedBox(
                height: 200.h,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) => RecentShare(
                    type: "save_contact",
                    isOnline: true,
                  ),
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
