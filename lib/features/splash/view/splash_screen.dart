import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';

import '../../../core/constants/navigation.dart';
import '../../auth/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Logo 1 animations: move up + scale + opacity + image transition
  late Animation<Offset> _logo1Offset;
  late Animation<double> _logo1Scale;
  late Animation<double> _logo1Opacity;
  late Animation<double> _logo1ImageProgress; // For image transition

  // Logo 2 animations: fade in + scale up
  late Animation<double> _logo2Opacity;
  late Animation<double> _logo2Scale;

  @override
  void initState() {
    super.initState();

    // Total duration: 10 seconds (5s logo1 + transition + 5s logo2)
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    // Calculate move-up distance (38% of screen height)
    final double moveUpDistance = 0.25.sh; // 38% of screen height

    // Logo1: Stays in center for 5s, then moves up from 5s to 6.5s
    _logo1Offset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -moveUpDistance),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.65, curve: Curves.easeOutCubic),
    ));

    _logo1Scale = Tween<double>(begin: 1.0, end: 0.75).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.65, curve: Curves.easeOutCubic),
    ));

    _logo1Opacity = Tween<double>(begin: 1.0, end: 0.9).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.65, curve: Curves.easeOut),
    ));

    // Image transition: Start changing from regular logo to top logo during movement
    _logo1ImageProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.52, 0.62,
            curve: Curves.easeInOut), // Slightly delayed for smoothness
      ),
    );

    // Logo2: Appears in center from 5.8s to 6.8s
    _logo2Opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.58, 0.75, curve: Curves.easeInOut),
    ));

    _logo2Scale = Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.58, 0.75, curve: Curves.easeOutBack),
    ));

    // Start animation
    _controller.forward();

    // Navigate after 10 seconds
    Timer(const Duration(seconds: 10), () {
      if (!mounted) return;
      navigateAndFinish(context, LoginScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImagePath: "assets/images/png/main.png",
      body: Stack(
        children: [
          // Logo 1: Smoothly transitions from regular to top version while moving
          AnimatedBuilder(
            animation: Listenable.merge([_controller, _logo1ImageProgress]),
            builder: (context, child) {
              // Determine which logo image to show based on progress
              final String logoPath = _logo1ImageProgress.value < 0.5
                  ? 'assets/images/png/logo1.png' // Regular logo
                  : 'assets/images/png/logo1--top.png'; // Top version

              // Calculate dimensions based on scale and image type
              final double currentScale = _logo1Scale.value;
              final double width =
                  _logo1ImageProgress.value < 0.5 ? 175.w : 175.w;
              final double height =
                  _logo1ImageProgress.value < 0.5 ? 160.h : 214.h;

              return Transform.translate(
                offset: _logo1Offset.value,
                child: Opacity(
                  opacity: _logo1Opacity.value,
                  child: ScaleTransition(
                    scale: AlwaysStoppedAnimation(currentScale),
                    child: Center(
                      child: Image.asset(
                        logoPath,
                        width: width,
                        height: height,
                        fit: BoxFit.contain,
                        // Smooth crossfade effect during transition
                        color: _logo1ImageProgress.value >= 0.5 &&
                                _logo1ImageProgress.value < 1.0
                            ? Colors.white.withOpacity(
                                1.0 - (_logo1ImageProgress.value - 0.5) * 2)
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Logo 2: Appears smoothly in the center
          Center(
            child: FadeTransition(
              opacity: _logo2Opacity,
              child: ScaleTransition(
                scale: _logo2Scale,
                child: SvgPicture.asset(
                  'assets/images/svg/logo.svg',
                  width: 184.w,
                  height: 94.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
