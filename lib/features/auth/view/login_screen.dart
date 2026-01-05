import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/component/custom_toast.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/component/widgets/app_text_field.dart';
import 'package:zumrah/core/component/widgets/app_title.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';
import 'package:zumrah/core/constants/navigation.dart';
import 'package:zumrah/core/cubit/global_cubit.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/core/utils/validator.dart';
import 'package:zumrah/features/auth/view/create_account_screen.dart';
import 'package:zumrah/features/auth/view/cubit/auth_cubit.dart';
import 'package:zumrah/features/auth/view/cubit/auth_state.dart';
import 'package:zumrah/features/auth/view/verification_screen.dart';

//! LoginScreen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginSuccess) {
              showToast(
                context,
                message: state.message.tr(context),
                state: ToastStates.success,
                duration: const Duration(seconds: 3),
              );
              context.read<GlobalCubit>().getProfile(forceRefresh: true);
              context.read<GlobalCubit>().changeBottomNavIndex(0);
              navigateAndFinish(
                context,
                BlocProvider(
                  create: (_) => AuthCubit(),
                  child: VerificationScreen(
                    emailOrPhoneForOtp:
                        context.read<AuthCubit>().loginEmailController.text,
                  ),
                ),
              );
            } else if (state is AuthFailure) {
              showToast(
                context,
                message: state.error.tr(context),
                state: ToastStates.error,
                duration: const Duration(seconds: 3),
              );
            }
          },
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();
            final formKey = GlobalKey<FormState>();

            return SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    left: 24.h,
                    right: 24.h,
                    top: 50.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(30.w),
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
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/png/logo1--top.png',
                                  width: 73.w,
                                  height: 89.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SectionHeader(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      titleKey: "auth_login_title",
                                      subtitleKey: "auth_login_subtitle",
                                    ),
                                    SizedBox(height: 30.h),
                                    AppTextField(
                                      controller:
                                          authCubit.loginEmailController,
                                      enabled:
                                          state is AuthLoading ? false : true,
                                      labelText:
                                          "auth_mobile_label".tr(context),
                                      hintText: "auth_mobile_label".tr(context),
                                      prefixIcon: Icon(Iconsax.mobile,
                                          color: AppColors.primaryColor),
                                      keyboardType: TextInputType.name,
                                      validator: (value) =>
                                          Validators.validatePhone(
                                              value, context),
                                    ),
                                    SizedBox(height: 20.h),
                                    AppButton(
                                      text: "auth_send_code_button".tr(context),
                                      isLoading: state is AuthLoading,
                                      suffixIcon: Icon(Iconsax.arrow_left,
                                          color: AppColors.white, size: 25.sp),
                                      onPressed: () {
                                        authCubit.attemptLogin(formKey);
                                      },
                                    ),
                                    SizedBox(height: 80.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: const Color(0xff5a7080)
                                                .withOpacity(0.3),
                                            thickness: 1.h,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Text(
                                            "auth_or".tr(context),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontFamily: 'Alexandria',
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff5a7080),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            color: const Color(0xff5a7080)
                                                .withOpacity(0.3),
                                            thickness: 1.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),
                                    AppButton(
                                      text: 'onboarding_create_account'
                                          .tr(context),
                                      type: AppButtonType.secondary,
                                      textStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                      onPressed: () {
                                        navigateTo(context,
                                            const CreateAccountScreen());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
