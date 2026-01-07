import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/home/view/widgets/app_bar_main.dart';
import 'package:zumrah/features/home/view/widgets/profile_header.dart';
import 'package:zumrah/features/profile/view/widgets/info_section.dart';

import '../../../core/constants/app_colors.dart';
import 'widgets/add_social_links_dialog.dart';
import 'widgets/info_value_item.dart';
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
        onMenuTap: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              ProfileHeader(
                name: "profile_name".tr(context),
                role: "profile_role".tr(context),
                trackingEnabled: false,
                onTrackingChanged: (_) {},
              ),
              SizedBox(height: 30.h),
              InfoSection(
                sectionIcon: Iconsax.user,
                sectionTitle: "profile_personal_section_title".tr(context),
                children: [
                  InfoValueItem(
                    label: "profile_label_full_name".tr(context),
                    value: "profile_name".tr(context),
                  ),
                  InfoValueItem(
                    label: "profile_label_job_title".tr(context),
                    value: "profile_role".tr(context),
                  ),
                ],
              ),
              InfoSection(
                sectionIcon: Iconsax.personalcard,
                sectionTitle: "profile_contact_methods_title".tr(context),
                children: [
                  InfoValueItem(
                    label: "profile_label_phone".tr(context),
                    value: "+966 50123 456789",
                  ),
                  InfoValueItem(
                    label: "profile_label_email".tr(context),
                    value: "user@domain.sa",
                  ),
                  SizedBox(height: 8.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "profile_social_links_title".tr(context),
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
                            label: "profile_social_instagram".tr(context),
                            url: "https://instagram.com/username",
                          ),
                          SocialLinkItem(
                            icon: Iconsax.d_cube_scan,
                            label: "profile_social_twitter".tr(context),
                            url: "https://twitter.com/username",
                          ),
                          SocialLinkItem(
                            icon: Iconsax.d_cube_scan,
                            label: "profile_social_linkedin".tr(context),
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
                                  AddSocialLinksDialog(),
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
                text: "profile_save_changes".tr(context),
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

  // AddSocialLinks dialog extracted to AddSocialLinksDialog widget file.
}
