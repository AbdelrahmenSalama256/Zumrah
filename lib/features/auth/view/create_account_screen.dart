import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/component/custom_toast.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/component/widgets/app_text_field.dart';
import 'package:zumrah/core/component/widgets/app_title.dart';
import 'package:zumrah/core/component/widgets/error_message_handler.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/core/utils/validator.dart';
import 'package:zumrah/features/auth/view/cubit/auth_cubit.dart';
import 'package:zumrah/features/auth/view/cubit/register_cubit.dart';
import 'package:zumrah/features/auth/view/cubit/register_state.dart';
import 'package:zumrah/features/auth/view/verification_screen.dart';

//! CreateAccountScreen - Individuals / Companies
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final GlobalKey<FormState> _individualFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _companyFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return CustomScaffold(
      backgroundImagePath: "assets/images/png/main.png",
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterError) {
              ErrorMessageHandler.showErrorToast(context, state.message);
            } else if (state is RegisterSuccess) {
              showToast(
                context,
                message: state.message.tr(context),
                state: ToastStates.success,
                duration: const Duration(seconds: 3),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => AuthCubit(),
                    child: VerificationScreen(
                      emailOrPhoneForOtp: state.emailForVerification,
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final registerCubit = context.read<RegisterCubit>();

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  top: 40.h,
                  bottom: isKeyboardOpen ? 10.h : 40.h,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
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
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 30.w,
                                right: 30.w,
                                top: 30.w,
                                bottom: 20.w,
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
                                  SizedBox(height: 20.h),
                                  SectionHeader(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    titleKey: "auth_create_account_title",
                                    subtitleKey: "auth_create_account_subtitle",
                                  ),
                                  SizedBox(height: 30.h),
                                  Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff2EADE0)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: TabBar(
                                      controller: _tabController,
                                      indicator: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [AppColors.g1, AppColors.g2],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      labelColor: Colors.white,
                                      unselectedLabelColor:
                                          const Color(0xff2797CE)
                                              .withOpacity(0.5),
                                      labelStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      dividerHeight: 0,
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            "auth_tab_companies".tr(context),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Alexandria',
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            "auth_tab_individuals".tr(context),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Alexandria',
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30.w,
                                      vertical: 20.h,
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    child: _buildCompanyForm(
                                      context,
                                      registerCubit,
                                      state,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30.w,
                                      vertical: 20.h,
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    child: _buildIndividualForm(
                                      context,
                                      registerCubit,
                                      state,
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIndividualForm(
    BuildContext context,
    RegisterCubit registerCubit,
    RegisterState state,
  ) {
    return Form(
      key: _individualFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            enabled: state is RegisterLoading ? false : true,
            controller: registerCubit.usernameController,
            labelText: "auth_username_label".tr(context),
            hintText: "auth_username_hint".tr(context),
            prefixIcon: Icon(Iconsax.user, color: AppColors.g1),
            validator: (value) => Validators.validateName(value, context),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            enabled: state is RegisterLoading ? false : true,
            controller: registerCubit.mobileController,
            labelText: "auth_mobile_label".tr(context),
            hintText: "auth_mobile_hint".tr(context),
            prefixIcon: Icon(Iconsax.mobile, color: AppColors.g1),
            keyboardType: TextInputType.phone,
            validator: (value) => Validators.validatePhone(value, context),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            enabled: state is RegisterLoading ? false : true,
            controller: registerCubit.emailController,
            labelText: "email".tr(context),
            hintText: "example@example.com",
            prefixIcon: Icon(Icons.email_outlined, color: AppColors.g1),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validators.validateEmail(value, context),
          ),
          SizedBox(height: 40.h),
          AppButton(
            text: "auth_send_code_button".tr(context),
            isLoading: state is RegisterLoading,
            suffixIcon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 25.sp,
            ),
            onPressed: () {
              if (_individualFormKey.currentState!.validate()) {
                registerCubit.attemptAccountCreation();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyForm(
    BuildContext context,
    RegisterCubit registerCubit,
    RegisterState state,
  ) {
    return Form(
      key: _companyFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            enabled: state is RegisterLoading ? false : true,
            controller: registerCubit.usernameController,
            labelText: "auth_company_name_label".tr(context),
            hintText: "auth_company_name_hint".tr(context),
            prefixIcon: Icon(Icons.business, color: AppColors.g1),
            validator: (value) => Validators.validateName(value, context),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            enabled: state is RegisterLoading ? false : true,
            controller: registerCubit.mobileController,
            labelText: "auth_mobile_label".tr(context),
            hintText: "auth_mobile_hint".tr(context),
            prefixIcon: Icon(Iconsax.mobile, color: AppColors.g1),
            keyboardType: TextInputType.phone,
            validator: (value) => Validators.validatePhone(value, context),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            enabled: state is RegisterLoading ? false : true,
            controller: registerCubit.emailController,
            labelText: "email".tr(context),
            hintText: "example@company.com",
            prefixIcon: Icon(Icons.email_outlined, color: AppColors.g1),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validators.validateEmail(value, context),
          ),
          SizedBox(height: 40.h),
          AppButton(
            text: "auth_send_code_button".tr(context),
            isLoading: state is RegisterLoading,
            suffixIcon:
                Icon(Icons.arrow_forward, color: Colors.white, size: 25.sp),
            onPressed: () {
              if (_companyFormKey.currentState!.validate()) {
                registerCubit.attemptAccountCreation();
              }
            },
          ),
        ],
      ),
    );
  }
}
