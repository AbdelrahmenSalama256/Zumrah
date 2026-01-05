import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/component/widgets/app_title.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/core/utils/validator.dart';
import 'package:zumrah/features/auth/view/create_account_screen.dart';
import 'package:zumrah/features/auth/view/cubit/auth_cubit.dart';
import 'package:zumrah/features/auth/view/cubit/auth_state.dart';

import '../../../core/component/custom_toast.dart';
import '../../../core/constants/navigation.dart';
import 'widgets/create_new_password_bottom_sheet.dart';

//! VerificationScreen - With Premium Glassmorphism Card Design
class VerificationScreen extends StatelessWidget {
  final String emailOrPhoneForOtp;
  const VerificationScreen({super.key, required this.emailOrPhoneForOtp});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final formKey = GlobalKey<FormState>();

    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 16.sp,
        color: Color(0xff5A7080),
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color(0xff5A7080).withOpacity(0.5),
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color(0xff5A7080).withOpacity(0.5),
          width: 2,
        ),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: Color(0xff5A7080).withOpacity(0.5), width: 2.4),
      ),
    );

    return CustomScaffold(
      backgroundImagePath:
          "assets/images/png/main.png", // Same background as login
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthOtpVerificationSuccess) {
            showToast(
              context,
              message: state.message.tr(context),
              state: ToastStates.success,
            );
            Navigator.pop(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => BlocProvider.value(
                  value: authCubit,
                  child: const CreateNewPasswordBottomSheet(),
                ),
              );
            });
          } else if (state is AuthFailure) {
            showToast(
              context,
              message: state.error.tr(context),
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: Stack(children: [
            Positioned(
                left: 24.w,
                right: 24.w,
                top: 50.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: EdgeInsets.all(20.w),
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
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/png/logo1--top.png',
                                  width: 73.w,
                                  height: 89.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SectionHeader(
                                fontSize: 16.sp,
                                titleKey: "comfirmation_code".tr(context),
                                subtitleKey:
                                    "auth_verification_message".tr(context) +
                                        emailOrPhoneForOtp,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              SizedBox(height: 40.h),
                              Pinput(
                                controller: authCubit.otpController,
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                validator: (value) =>
                                    Validators.validateOtp(value, context),
                              ),
                              SizedBox(height: 40.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      text: "تأكيد".tr(context),
                                      isLoading: state is AuthLoading,
                                      textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: 'Alexandria',
                                      ),
                                      prefixIcon: Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.white,
                                          size: 25.sp),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          authCubit
                                              .verifyOtpForAccountCreation();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: AppButton(
                                      text: "اعادة ارسال".tr(context),
                                      isLoading: state is AuthLoading,
                                      type: AppButtonType.secondary,
                                      textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.g1,
                                        fontFamily: 'Alexandria',
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14.h, horizontal: 10.w),
                                      prefixIcon: Icon(Iconsax.refresh,
                                          color: AppColors.g1, size: 25.sp),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          authCubit
                                              .verifyOtpForAccountCreation();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 80.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xff5a7080).withOpacity(0.3),
                                      thickness: 1.h,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      "ليس لديك حساب ",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff5a7080),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xff5a7080).withOpacity(0.3),
                                      thickness: 1.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              AppButton(
                                text: 'تسجيل حساب جديد',
                                type: AppButtonType.secondary,
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Alexandria',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  navigateTo(context, CreateAccountScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ]));
        },
      ),
    );
  }
}
