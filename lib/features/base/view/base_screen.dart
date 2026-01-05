import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/cubit/global_state.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  static final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        final selectedIndex = context.read<GlobalCubit>().currentNavIndex;
        return CustomScaffold(
          backgroundImagePath: "assets/images/png/main.png",
          body: SafeArea(
            child: Stack(
              children: [
                IndexedStack(
                  index: selectedIndex,
                  children: _screens,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildNavItem(
                                  context, Iconsax.home, Iconsax.home, 0),
                              _buildNavItem(
                                  context, Iconsax.chart_2, Iconsax.chart_2, 1),
                              SizedBox(width: 60.w),
                              _buildNavItem(context, Iconsax.notification_bing,
                                  Iconsax.notification_bing, 2),
                              _buildNavItem(context, Iconsax.setting_2,
                                  Iconsax.setting_2, 3),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40.h,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      context.read<GlobalCubit>().changeBottomNavIndex(0);
                    },
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData outlineIcon, IconData filledIcon, int index) {
    final selectedIndex = context.read<GlobalCubit>().currentNavIndex;
    return GestureDetector(
      onTap: () => context.read<GlobalCubit>().changeBottomNavIndex(index),
      child: Container(
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

// Placeholder Screens (Replace with your actual screens)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(
      child: Text('Home', style: TextStyle(fontSize: 30, color: AppColors.g1)));
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(
      child:
          Text('Search', style: TextStyle(fontSize: 30, color: AppColors.g1)));
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(
      child: Text('Favorites',
          style: TextStyle(fontSize: 30, color: AppColors.g1)));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(
      child:
          Text('Profile', style: TextStyle(fontSize: 30, color: AppColors.g1)));
}
