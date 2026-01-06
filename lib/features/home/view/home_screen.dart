import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/features/home/view/widgets/app_bar_main.dart';

import '../../../core/constants/app_colors.dart';
import 'widgets/home_services_card.dart';
import 'widgets/switcher.dart';

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
              ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Stack(
                    children: [
                      Container(
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
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 112.w,
                                    height: 112.h,
                                    padding: EdgeInsets.all(7.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: AlignmentDirectional.topStart,
                                        end: AlignmentDirectional.topEnd,
                                        colors: [
                                          Colors.white.withOpacity(0.50),
                                          Colors.white.withOpacity(0.8),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x1A000000),
                                          offset: const Offset(0, 4),
                                          blurRadius: 6,
                                          spreadRadius: -4,
                                        ),
                                        BoxShadow(
                                          color: const Color(0x1A000000),
                                          offset: const Offset(0, 10),
                                          blurRadius: 15,
                                          spreadRadius: -3,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/images/user_avatar.jpg",
                                        width: 98.w,
                                        height: 98.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    start: 5.w,
                                    bottom: 10.h,
                                    child: Container(
                                      width: 24.w,
                                      height: 24.h,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return const LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xFF5B8ED1),
                                                Color(0xFF65DFE6),
                                              ],
                                            ).createShader(bounds);
                                          },
                                          blendMode: BlendMode.srcIn,
                                          child: Icon(
                                            Iconsax.verify5,
                                            size: 20.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "عبدالله الشمري",
                                    style: TextStyle(
                                      color: Color(0xff5A7080),
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Alexandria',
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "مسؤول تسويق",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Alexandria',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24.r),
                              child: Container(
                                // Removed BackdropFilter
                                width: 285.w,
                                height: 90.h,
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xA6FFFFFF),
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.4),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x0D000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.w,
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/images/svg/tracking.svg",
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "حالة التتبع",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            color: AppColors.secondaryColor,
                                            fontFamily: 'Alexandria',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "نشط حالياً",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Color(0xff16A34A),
                                            fontFamily: 'Alexandria',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    IconSwitch(
                                      value: trackingEnabled,
                                      onChanged: (value) {
                                        setState(() {
                                          trackingEnabled = value;
                                        });
                                        debugPrint('Tracking: $value');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 96.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: AlignmentDirectional.topEnd,
                              end: AlignmentDirectional.topStart,
                              colors: [
                                Color.fromRGBO(46, 174, 224, 0.1),
                                Color.fromRGBO(46, 174, 224, 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "الوصول السريع",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.secondaryColor,
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              // Fixed height GridView
              SizedBox(
                height:
                    300.h, // Set a fixed height or calculate based on content
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1.2,
                  children: [
                    HomeServicesCard(
                      icon: Iconsax.home,
                      title: "التقارير",
                      subtitle: "عرض التقرير الشهري",
                      onTap: () {
                        debugPrint('تقارير tapped');
                      },
                    ),
                    HomeServicesCard(
                      icon: Icons.groups_outlined,
                      iconColor: Color(0xff9333EA),
                      title: "فريق العمل",
                      subtitle: "12 موظف نشط",
                      onTap: () {
                        debugPrint('مواعيد tapped');
                      },
                    ),
                    HomeServicesCard(
                      icon: Iconsax.chart_21,
                      title: "التحليلات",
                      iconColor: Color(0xffEA580C),
                      subtitle: "زيادة بنسبة 5%",
                      onTap: () {
                        debugPrint('رسائل tapped');
                      },
                    ),
                    HomeServicesCard(
                      icon: Iconsax.setting_2,
                      iconColor: Color(0xff4B5563),
                      title: "الإعدادات",
                      subtitle: "تفضيلات الحساب",
                      onTap: () {
                        debugPrint('إعدادات tapped');
                      },
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20.h),
              Stack(
                children: [
                  Positioned.fill(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset("assets/images/png/slide.png",
                        fit: BoxFit.cover),
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
                      color: Colors.white
                          .withOpacity(0.8), // خليها 0 عشان الخلفية واضحة
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            "تحديث جديد",
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
                          "ملخص الإنجاز",
                          style: TextStyle(
                            color: AppColors.secondaryHeadTextColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Alexandria',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "تم اكتمال 8% من اهداف الربع الحالي بنجاج.",
                          style: TextStyle(
                            color: Color(0xff5A7080),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Alexandria',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
