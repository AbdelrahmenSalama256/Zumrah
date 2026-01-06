import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/features/home/view/widgets/app_bar_main.dart';
import 'package:zumrah/features/profile/view/widgets/info_section.dart';

import '../../../core/constants/app_colors.dart';
import 'widgets/info_value_item.dart';
import 'widgets/social_link_filed.dart';
import 'widgets/social_link_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarMain(
        title: "الملف الشخصي",
        onBackTap: () {
          context.read<GlobalCubit>().changeBottomNavIndex(0);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
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
                                width: 30.w,
                                height: 30.h,
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
                                      Iconsax.camera,
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
                    ],
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
              SizedBox(height: 30.h),
              InfoSection(
                sectionIcon: Iconsax.user,
                sectionTitle: "البيانات الشخصية",
                children: [
                  InfoValueItem(
                    label: "الاسم الكامل",
                    value: "عبدالله الشمري",
                  ),
                  InfoValueItem(
                    label: "المسمى الوظيفي",
                    value: "مسؤول تسويق",
                  ),
                ],
              ),
              InfoSection(
                sectionIcon: Iconsax.personalcard,
                sectionTitle: "وسائل التواصل",
                children: [
                  InfoValueItem(
                    label: "رقم الجوال",
                    value: "+966 50123 456789",
                  ),
                  InfoValueItem(
                    label: "البريد الإلكتروني",
                    value: "user@domain.sa",
                  ),
                  SizedBox(height: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "روابط التواصل الاجتماعي",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Alexandria',
                          fontWeight: FontWeight.w600,
                          color:
                              AppColors.secondaryHeadTextColor.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      // Instead of ListView, use Wrap:
                      Wrap(
                        spacing: 10.w,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.up,
                        runSpacing: 10.h,
                        children: [
                          SocialLinkItem(
                            icon: Iconsax.instagram,
                            label: "إنستغرام",
                            url: "https://instagram.com/username",
                          ),
                          SocialLinkItem(
                            icon: Iconsax.d_cube_scan,
                            label: "تويتر / إكس",
                            url: "https://twitter.com/username",
                          ),
                          SocialLinkItem(
                            icon: Iconsax.d_cube_scan,
                            label: "لينكدإن",
                            url: "https://linkedin.com/in/username",
                          ),
                          GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierColor:
                                  AppColors.primaryColor.withOpacity(0.3),
                              useSafeArea: true,
                              builder: (dialogContext) =>
                                  _addSocialLinks(dialogContext),
                            ),
                            child: Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white.withOpacity(1),
                                  width: 2.w,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Iconsax.add,
                                  size: 30.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              AppButton(
                text: "حفظ التعديلات",
                onPressed: () {
                  // Handle save action
                },
                width: double.infinity,
                height: 56.h,
                prefixIcon: Icon(Icons.check_circle_outline_outlined,
                    size: 20.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addSocialLinks(BuildContext dialogContext) {
    final List<TextEditingController> controllers = [
      TextEditingController(), // field واحد افتراضي
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: double.infinity,
                color: Colors.white.withOpacity(0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// close button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(1),
                            width: 2.w,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close_rounded,
                            size: 30.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    /// dynamic fields
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          children: List.generate(
                            controllers.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: SocialLinkField(
                                hintText: "أدخل رابط التواصل الاجتماعي",
                                controller: controllers[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    /// add new field
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          controllers.add(TextEditingController());
                        });
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(1),
                            width: 2.w,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 30.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    /// save button
                    AppButton(
                      text: "حفظ ",
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      width: 200.w,
                      height: 56.h,
                      backgroundColor: AppColors.white,
                      textStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Alexandria',
                      ),
                      prefixIcon: Icon(
                        Icons.check_circle_outline_outlined,
                        size: 20.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
