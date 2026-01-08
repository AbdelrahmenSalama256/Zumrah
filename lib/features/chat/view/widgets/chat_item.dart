import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/constants/app_colors.dart';

class ChatItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? dateTime;
  final bool? isOnline;
  final String? avatarUrl;
  final String? unreadCount;
  final VoidCallback? onTap;
  final bool isGroup;
  final int? memberCount; // For groups only

  const ChatItem({
    super.key,
    this.title,
    this.subtitle,
    this.dateTime,
    this.isOnline = false,
    this.avatarUrl,
    this.unreadCount,
    this.onTap,
    required this.isGroup,
    this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withOpacity(1),
                width: 2.w,
              ),
              color: Colors.white.withOpacity(0.6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 30.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar Stack with group indicator
                          Stack(
                            children: [
                              // Main avatar container
                              Container(
                                width: 48.w,
                                height: 48.w,
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.all(0.w),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 2.r,
                                      offset: Offset(0, 1.h),
                                    ),
                                  ],
                                ),
                                child: _buildAvatar(),
                              ),

                              // Online indicator for single chats
                              if (!isGroup && isOnline == true)
                                PositionedDirectional(
                                  bottom: 0,
                                  start: 0,
                                  child: Container(
                                    width: 14.w,
                                    height: 14.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.w,
                                      ),
                                    ),
                                  ),
                                ),

                              // Group indicator badge
                              if (isGroup)
                                PositionedDirectional(
                                  top: 0,
                                  end: 0,
                                  child: Container(
                                    width: 20.w,
                                    height: 20.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.w,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.r,
                                          offset: Offset(0, 2.h),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Iconsax.people,
                                        size: 10.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(width: 12.w),

                          // Chat content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Title row with group member count
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              title ?? "محمد أحمد",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors
                                                    .secondaryHeadTextColor,
                                                fontFamily: 'Alexandria',
                                              ),
                                            ),
                                          ),
                                          if (isGroup && memberCount != null)
                                            Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      start: 6.w),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 6.w,
                                                vertical: 2.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Text(
                                                '$memberCount',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.primaryColor,
                                                  fontFamily: 'Alexandria',
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      dateTime ?? "الآن",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryHeadTextColor
                                            .withOpacity(0.3),
                                        fontFamily: 'Alexandria',
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 4.h),

                                // Subtitle row with unread count
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          // Group typing indicator icon
                                          if (isGroup && unreadCount != "0")
                                            Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      end: 4.w),
                                              child: Icon(
                                                Iconsax.messages,
                                                size: 12.sp,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),

                                          // Subtitle text
                                          Flexible(
                                            child: Text(
                                              _formatSubtitle(subtitle ??
                                                  "مرحبًا! كيف حالك؟"),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .secondaryHeadTextColor,
                                                fontFamily: 'Alexandria',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(width: 8.w),

                                    // Unread count badge
                                    if (unreadCount != "0" &&
                                        unreadCount != null)
                                      Container(
                                        width: 24.w,
                                        height: 24.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.3),
                                              blurRadius: 4.r,
                                              spreadRadius: 1.r,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            unreadCount!,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.white,
                                              fontFamily: 'Alexandria',
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Side gradient indicator for unread chats
                if (unreadCount != "0" && unreadCount != null)
                  PositionedDirectional(
                    end: 0,
                    child: Container(
                      width: 4.w,
                      height: 88.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(100.r),
                          bottomStart: Radius.circular(100.r),
                        ),
                        gradient: LinearGradient(
                          colors: [AppColors.g1, AppColors.g2],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (isGroup) {
      // Group avatar with stacked members or group icon
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor.withOpacity(0.1),
              AppColors.primaryColor.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Icon(
            Iconsax.people,
            size: 24.sp,
            color: AppColors.primaryColor,
          ),
        ),
      );
    } else {
      // Single user avatar
      return Image.asset(
        avatarUrl ?? 'assets/images/png/avatar.png',
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Iconsax.user,
            size: 24.sp,
            color: AppColors.g2,
          );
        },
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  String _formatSubtitle(String subtitle) {
    if (isGroup) {
      // For groups, add sender name prefix if not already present
      if (!subtitle.contains(':')) {
        return subtitle;
      }
    }
    return subtitle;
  }
}
