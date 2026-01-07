import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/home/view/widgets/switcher.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final bool trackingEnabled;
  final ValueChanged<bool> onTrackingChanged;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
    required this.trackingEnabled,
    required this.onTrackingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                          name,
                          style: TextStyle(
                            color: const Color(0xff5A7080),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Alexandria',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          role,
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
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/svg/tracking.svg",
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "home_tracking_title".tr(context),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.secondaryColor,
                                  fontFamily: 'Alexandria',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "home_tracking_status_active".tr(context),
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
                            onChanged: onTrackingChanged,
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
    );
  }
}
