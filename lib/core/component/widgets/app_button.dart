import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';

enum AppButtonType { primary, secondary, text, outline }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final Color? overrideTextColor;
  final Color? backgroundColor; // Optional solid background override

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = 60,
    this.width,
    this.padding,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.overrideTextColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    switch (type) {
      case AppButtonType.primary:
        return _buildPrimaryButton(context, isDisabled);
      case AppButtonType.secondary:
        return _buildGradientBorderButton(context, isDisabled,
            isSecondary: true);
      case AppButtonType.text:
        return _buildTextButton(context, isDisabled);
      case AppButtonType.outline:
        return _buildGradientBorderButton(context, isDisabled,
            isSecondary: false);
    }
  }

  // Primary: Gradient Fill (or solid if backgroundColor provided)
  Widget _buildPrimaryButton(BuildContext context, bool isDisabled) {
    final bool useSolidColor = backgroundColor != null;
    final Color effectiveBgColor = backgroundColor ?? AppColors.g1;

    final Color smartTextColor = overrideTextColor ??
        (useSolidColor && effectiveBgColor.computeLuminance() > 0.5
            ? AppColors.textBlack
            : Colors.white);

    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: Container(
        width: isFullWidth ? double.infinity : width?.w,
        height: height.h,
        decoration: BoxDecoration(
          gradient: useSolidColor
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isDisabled
                      ? [
                          AppColors.g1.withOpacity(0.6),
                          AppColors.g2.withOpacity(0.6)
                        ]
                      : [AppColors.g1, AppColors.g2],
                ),
          color: useSolidColor
              ? effectiveBgColor.withOpacity(isDisabled ? 0.6 : 1.0)
              : null,
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
          boxShadow: isDisabled
              ? null
              : [
                  BoxShadow(
                    color: (useSolidColor ? effectiveBgColor : AppColors.g1)
                        .withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius ?? BorderRadius.circular(16.r),
            onTap: isDisabled ? null : onPressed,
            child: Center(child: _buildButtonContent(smartTextColor)),
          ),
        ),
      ),
    );
  }

  // Shared: Gradient Border Button (used for secondary & outline)
  Widget _buildGradientBorderButton(BuildContext context, bool isDisabled,
      {required bool isSecondary}) {
    final double borderWidth = isSecondary ? 1.5 : 2.5; // Thicker for outline
    final Color textColor = overrideTextColor ?? AppColors.primaryLight;

    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: Container(
        width: isFullWidth ? double.infinity : width?.w,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: isDisabled
                ? [AppColors.g1.withOpacity(0.5), AppColors.g2.withOpacity(0.5)]
                : [AppColors.g1, AppColors.g2],
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(borderWidth),
          decoration: BoxDecoration(
            color: backgroundColor ??
                (isSecondary ? Colors.white : Colors.transparent),
            borderRadius:
                borderRadius ?? BorderRadius.circular(16.r - borderWidth),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius ?? BorderRadius.circular(16.r),
              onTap: isDisabled ? null : onPressed,
              child: Center(
                child: _buildButtonContent(textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Text Button
  Widget _buildTextButton(BuildContext context, bool isDisabled) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width?.w,
      height: height.h,
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(16.r),
          ),
        ),
        child: _buildButtonContent(overrideTextColor ?? AppColors.primaryLight),
      ),
    );
  }

  Widget _buildButtonContent(Color defaultTextColor) {
    if (isLoading) {
      return SizedBox(
        height: 28.h,
        width: 28.w,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(defaultTextColor),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          IconTheme(
            data: IconThemeData(color: defaultTextColor, size: 20.sp),
            child: prefixIcon!,
          ),
          SizedBox(width: 10.w),
        ],
        Text(
          text,
          style: textStyle ??
              TextStyle(
                color: defaultTextColor,
                fontSize: 16.sp,
                fontFamily: 'Alexandria',
                fontWeight: FontWeight.w700,
              ),
        ),
        if (suffixIcon != null) ...[
          SizedBox(width: 10.w),
          IconTheme(
            data: IconThemeData(color: defaultTextColor, size: 20.sp),
            child: suffixIcon!,
          ),
        ],
      ],
    );
  }
}
