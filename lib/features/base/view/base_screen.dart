import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  // Your 4 main screens
  static final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImagePath:
          "assets/images/png/main.png", // Optional: keep your app background
      body: SafeArea(
        child: Stack(
          children: [
            // Current Screen Content
            IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),

            // Floating Bottom Navigation Bar with Notch & Logo Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                height: 62.h,
                decoration: BoxDecoration(
                  color: Colors.white, // Keep frosted glass feel
                  borderRadius: BorderRadius.circular(32.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.8),
                    width: 1,
                  ),
                  boxShadow: [
                    // First shadow
                    BoxShadow(
                      color: const Color(0xFF0E4F93)
                          .withOpacity(0.05), // #0E4F930D ≈ opacity 0.05
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                    // Second shadow
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
                          _buildNavItem(Iconsax.home, Iconsax.home, 0),
                          _buildNavItem(Iconsax.chart_2, Iconsax.chart_2, 1),
                          SizedBox(width: 60.w), // Space for center logo button
                          _buildNavItem(Iconsax.notification_bing,
                              Iconsax.notification_bing, 2),
                          _buildNavItem(
                              Iconsax.setting_2, Iconsax.setting_2, 3),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Center Floating Logo Button
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Optional: special action for logo (e.g. go to main page)
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Container(
                  width: 62.w,
                  height: 62.w,
                  decoration: BoxDecoration(
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
  }

  Widget _buildNavItem(IconData outlineIcon, IconData filledIcon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedIndex == index
              ? Color(0xff2eade0).withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Icon(
          _selectedIndex == index ? filledIcon : outlineIcon,
          color: _selectedIndex == index
              ? AppColors.primaryColor
              : Color(0xff0e4f93).withOpacity(0.7),
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
