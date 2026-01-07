import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';
import 'package:zumrah/core/constants/navigation.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/cubit/global_state.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/home/view/widgets/custom_drawer.dart';

import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../statistics/view/statistics_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  static final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const StatisticsScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        final selectedIndex = context.read<GlobalCubit>().currentNavIndex;
        return CustomScaffold(
          scaffoldKey: drawerKey,
          drawer: const CustomDrawer(),
          backgroundImagePath: "assets/images/png/main.png",
          body: WillPopScope(
            onWillPop: () async {
              if (selectedIndex != 0) {
                context.read<GlobalCubit>().changeBottomNavIndex(0);
                return false;
              } else {
                return true;
              }
            },
            child: SafeArea(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 85.h),
                    color: Colors.transparent,
                    child: IndexedStack(
                      index: selectedIndex,
                      children: _screens,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 7.h),
                        height: 62.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.8),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0E4F93).withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: -4,
                            ),
                            BoxShadow(
                              color: const Color(0xFF0E4F93).withOpacity(0.05),
                              offset: const Offset(0, 10),
                              blurRadius: 15,
                              spreadRadius: -3,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: BottomAppBar(
                              color: Colors.transparent,
                              shape: const CircularNotchedRectangle(),
                              notchMargin: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildNavItem(
                                      context, Iconsax.home, Iconsax.home, 0),
                                  _buildNavItem(context, Iconsax.chart_2,
                                      Iconsax.chart_2, 1),
                                  SizedBox(width: 60.w),
                                  _buildNavItem(
                                      context,
                                      CupertinoIcons.chat_bubble,
                                      CupertinoIcons.chat_bubble,
                                      2),
                                  _buildNavItem(
                                      context, Iconsax.user, Iconsax.user, 3),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Center Button with restricted tap area
                  Positioned(
                    bottom: 40.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 62.w, // Same as button width
                        height: 62.w, // Same as button height
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _showFullScreenPopup(context),
                            borderRadius: BorderRadius.circular(31.w),
                            splashColor:
                                AppColors.primaryColor.withOpacity(0.3),
                            highlightColor: Colors.transparent,
                            child: Container(
                              width: 62.w,
                              height: 62.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/png/logo1.png',
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Method to show popup
  void _showFullScreenPopup(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      barrierColor: AppColors.primaryColor.withOpacity(0.3),
      useSafeArea: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.all(8.w),
        child: _buildFullScreenBlurPopup(context),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData outlineIcon,
      IconData filledIcon, int index) {
    final selectedIndex = context.read<GlobalCubit>().currentNavIndex;
    return GestureDetector(
      onTap: () => context.read<GlobalCubit>().changeBottomNavIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedIndex == index
              ? const Color(0xff2eade0).withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Icon(
          selectedIndex == index ? filledIcon : outlineIcon,
          color: selectedIndex == index
              ? AppColors.primaryColor
              : const Color(0xff0e4f93).withOpacity(0.7),
          size: 28.sp,
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(
      child: Text('Favorites',
          style: TextStyle(fontSize: 30, color: AppColors.g1)));
}

Widget _buildFullScreenBlurPopup(BuildContext dialogContext) {
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
              SvgPicture.asset(
                'assets/images/svg/zumrah_icon.svg',
                width: 129.0001678466797.w,
                height: 71.5074691772461.w,
              ),
              SizedBox(height: 24.h),
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 310.w,
                  padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 25.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(1),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0D000000),
                        offset: Offset(0, 4.h),
                        blurRadius: 30.r,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "share_profile_title".tr(dialogContext),
                          style: TextStyle(
                            fontSize: 17.71.sp,
                            fontFamily: 'Alexandria',
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryHeadTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 200.w,
                          height: 200.w,
                          padding: EdgeInsets.all(25.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/svg/qr.svg',
                            width: 102.w,
                            height: 102.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Text(
                          "scan_qr_label".tr(dialogContext),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Alexandria',
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryHeadTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: const Color(0xff5A7080),
                              thickness: 1.5,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              "or_label".tr(dialogContext),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Alexandria',
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryHeadTextColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: const Color(0xff5A7080),
                              thickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // NFC Share Button
                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: AppButton(
                          backgroundColor: AppColors.primaryColor,
                          height: 60.h,
                          text: "share_nfc".tr(dialogContext),
                          onPressed: () {
                            // Close current dialog first
                            Navigator.of(dialogContext).pop();
                            // Then open NFC popup after a short delay (no await to avoid using BuildContext across async gap)
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              _showNfcPopup(dialogContext);
                            });
                          },
                          prefixIcon: SvgPicture.asset(
                            'assets/images/svg/share_nfc.svg',
                            width: 24.w,
                            height: 20.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      // Copy Link Button
                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: AppButton(
                          backgroundColor: AppColors.primaryColor,
                          height: 60.h,
                          text: "copy_link_label".tr(dialogContext),
                          onPressed: () {
                            // Add your copy link functionality here
                            Navigator.of(dialogContext).pop();
                          },
                          prefixIcon: Icon(Iconsax.link,
                              size: 24.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

void _showNfcPopup(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    barrierColor: AppColors.primaryColor.withOpacity(0.3),
    useSafeArea: true,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.all(8.w),
      child: _buildNfcPopupContent(context),
    ),
  );
}

Widget _buildNfcPopupContent(BuildContext dialogContext) {
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
              SvgPicture.asset(
                'assets/images/svg/zumrah_icon.svg',
                width: 129.0001678466797.w,
                height: 71.5074691772461.w,
              ),
              SizedBox(height: 24.h),
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 310.w,
                  padding: EdgeInsets.fromLTRB(20.w, 25.h, 20.w, 25.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(1),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0D000000),
                        offset: Offset(0, 4.h),
                        blurRadius: 30.r,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "share_profile_title".tr(dialogContext),
                          style: TextStyle(
                            fontSize: 17.71.sp,
                            fontFamily: 'Alexandria',
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryHeadTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 200.w,
                          height: 200.w,
                          padding: EdgeInsets.all(25.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/svg/share_nfc.svg',
                            width: 102.w,
                            height: 102.w,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Text(
                          "nfc_proximity_message".tr(dialogContext),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Alexandria',
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryHeadTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: AppButton(
                          backgroundColor: AppColors.primaryColor,
                          height: 60.h,
                          text: "confirm_nfc_button".tr(dialogContext),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          prefixIcon: SvgPicture.asset(
                            'assets/images/svg/share_nfc.svg',
                            width: 24.w,
                            height: 20.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
