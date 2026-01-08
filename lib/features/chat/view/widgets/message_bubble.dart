import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/constants/app_colors.dart';
import '../../data/models/massage_model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool showSenderName; // For group chats
  final ChatType chatType;

  const MessageBubble({
    super.key,
    required this.message,
    required this.showSenderName,
    required this.chatType,
  });

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMe;
    final localeCode = Localizations.localeOf(context).languageCode;
    final timeString =
        intl.DateFormat('hh:mm a', localeCode).format(message.timestamp);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment:
            !isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            // textDirection: !isMine ? TextDirection.ltr : TextDirection.rtl,
            mainAxisAlignment:
                !isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (chatType == ChatType.group && isMine) ...[
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
                      width: 30.w,
                      height: 30.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
              ],
              Container(
                constraints: BoxConstraints(maxWidth: 280.w),
                decoration: BoxDecoration(
                  color: !isMine
                      ? AppColors.primaryColor
                      : const Color(0xFFF5F5F5),
                  // borderRadius: BorderRadius.circular(16.r),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(16.r),
                    bottomStart: Radius.circular(16.r),
                    topEnd: isMine ? Radius.circular(16.r) : Radius.circular(0),
                    topStart:
                        isMine ? Radius.circular(0) : Radius.circular(16.r),
                  ),
                  border: Border.all(
                    color: isMine
                        ? AppColors.primaryColor
                        : const Color(0xFFF5F5F5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isMine
                          ? Colors.transparent
                          : Color(0x4D2EAEE0), // #2EAEE04D
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: isMine
                          ? Color(0xff000000).withOpacity(0.1)
                          : Color(0x4D2EAEE0), // #2EAEE04D
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -3,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: !isMine
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.content,
                      textDirection: TextDirection.rtl, // Arabic text is RTL
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: !isMine
                            ? Colors.white
                            : AppColors.secondaryHeadTextColor,
                        fontFamily: 'Alexandria',
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (chatType == ChatType.group && !isMine) ...[
                SizedBox(
                  width: 6.w,
                ),
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
                      width: 30.w,
                      height: 30.w,
                    ),
                  ),
                ),
              ],
            ],
          ),
          // SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              timeString,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.secondaryHeadTextColor.withOpacity(0.6),
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w500
                  // color: isMine ? Colors.white.withOpacity(0.7) : Colors.grey[600],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
