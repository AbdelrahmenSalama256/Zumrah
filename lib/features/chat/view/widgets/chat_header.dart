import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';

import '../../data/models/massage_model.dart';

class ChatHeader extends StatelessWidget {
  final ChatUser? chatUser;
  final ChatGroup? chatGroup;
  final ChatType chatType;
  final VoidCallback onBackPressed;

  const ChatHeader({
    super.key,
    required this.chatUser,
    required this.chatGroup,
    required this.chatType,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isGroup = chatType == ChatType.group;
    final displayName =
        isGroup ? (chatGroup?.name ?? '') : (chatUser?.name ?? '');
    final displaySubtitle =
        isGroup ? (chatGroup?.subtitle ?? '') : (chatUser?.subtitle ?? '');

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xffe8eff1).withOpacity(1),
                const Color(0xffe8eff1).withOpacity(0.5),
              ],
              begin: AlignmentDirectional.topEnd,
              end: AlignmentDirectional.bottomStart,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(24.r),
              bottomStart: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        "assets/images/png/avatar.png",
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    child: Container(
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        Icons.circle,
                        size: 10.w,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryColor,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    displaySubtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryColor.withOpacity(0.4),
                      fontFamily: 'Alexandria',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
