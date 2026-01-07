import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/profile/view/widgets/social_link_filed.dart';

class AddSocialLinksDialog extends StatefulWidget {
  const AddSocialLinksDialog({super.key});

  @override
  State<AddSocialLinksDialog> createState() => _AddSocialLinksDialogState();
}

class _AddSocialLinksDialogState extends State<AddSocialLinksDialog> {
  final List<TextEditingController> controllers = [TextEditingController()];

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context).pop();
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
                            hintText: "profile_social_link_hint".tr(context),
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
                  text: "profile_save_label".tr(context),
                  onPressed: () {
                    Navigator.of(context).pop();
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
  }
}
