import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/locale/app_loacl.dart';

void showToast(
  BuildContext context, {
  required String message,
  required ToastStates state,
  Duration duration = const Duration(seconds: 3),
  ToastStyle style = ToastStyle.gradient, // Default to gradient
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: _buildToastContent(message, state, style),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      padding: EdgeInsets.zero,
    ),
  );
}

Widget _buildToastContent(String message, ToastStates state, ToastStyle style) {
  // All styles now use the gradient version
  return _GradientToast(message: message, state: state);
}

enum ToastStates {
  success,
  error,
  warning,
  info,
  delivery,
  orderPlaced,
}

enum ToastStyle {
  gradient, // Beautiful gradient background (default)
  // You can add others later if needed
}

//! _GradientToast - Premium Gradient Style
class _GradientToast extends StatefulWidget {
  final String message;
  final ToastStates state;

  const _GradientToast({
    required this.message,
    required this.state,
  });

  @override
  State<_GradientToast> createState() => _GradientToastState();
}

class _GradientToastState extends State<_GradientToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<double>(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      AppColors.g1, // Your main gradient start
      AppColors.g2, // Your main gradient end
    ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: ScaleTransition(
              scale: AlwaysStoppedAnimation(_scaleAnimation.value),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.g1.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        _getSimpleIcon(widget.state),
                        color: Colors.white,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getToastTitle(context, widget.state),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.message,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.95),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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

// Helper functions remain the same

IconData _getSimpleIcon(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      return Icons.check_circle_outline;
    case ToastStates.error:
      return Icons.error_outline;
    case ToastStates.warning:
      return Icons.warning_amber_outlined;
    case ToastStates.delivery:
      return Icons.local_shipping_outlined;
    case ToastStates.orderPlaced:
      return Icons.shopping_bag_outlined;
    default:
      return Icons.info_outline;
  }
}

String _getToastTitle(BuildContext context, ToastStates state) {
  switch (state) {
    case ToastStates.success:
      return 'toast_perfect'.tr(context);
    case ToastStates.error:
      return 'toast_oops'.tr(context);
    case ToastStates.warning:
      return 'toast_heads_up'.tr(context);
    case ToastStates.delivery:
      return 'toast_on_the_way'.tr(context);
    case ToastStates.orderPlaced:
      return 'toast_order_placed'.tr(context);
    default:
      return 'toast_info'.tr(context);
  }
}

extension GradientToastExtension on BuildContext {
  void showGradientToast(
    String message, {
    ToastStates state = ToastStates.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      this,
      message: message,
      state: state,
      style: ToastStyle.gradient,
      duration: duration,
    );
  }
}
