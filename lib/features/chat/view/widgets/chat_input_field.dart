import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zumrah/core/component/widgets/app_text_field.dart';
import 'package:zumrah/core/locale/app_loacl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/massage_model.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSendMessage;
  final ChatType chatType;
  final bool showAttachmentButton;

  const ChatInputField({
    super.key,
    required this.onSendMessage,
    this.chatType = ChatType.single,
    this.showAttachmentButton = true,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.image, color: AppColors.primaryColor),
                title: Text('صورة من المعرض'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Pick image
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
                title: Text('التقاط صورة'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Take photo
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_file, color: AppColors.primaryColor),
                title: Text('ملف'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Pick file
                },
              ),
              if (widget.chatType == ChatType.group)
                ListTile(
                  leading: Icon(Icons.group_add, color: AppColors.primaryColor),
                  title: Text('إضافة أعضاء'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Add members
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xffe8eff1).withOpacity(1),
                const Color(0xffe8eff1).withOpacity(0.8),
              ],
              end: AlignmentDirectional.topEnd,
              begin: AlignmentDirectional.bottomStart,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(24.r),
              topStart: Radius.circular(24.r),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: Row(
            children: [
              // Attachment button
              if (widget.showAttachmentButton)
                GestureDetector(
                  onTap: () => _showAttachmentOptions(context),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44.w,
                    height: 44.w,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.add,
                        color: AppColors.secondaryHeadTextColor,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),

              if (widget.showAttachmentButton) SizedBox(width: 12.w),

              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: AppTextField(
                    controller: _controller,
                    hintText: widget.chatType == ChatType.group
                        ? 'chat_write_group_message'.tr(context)
                        : 'chat_write_message'.tr(context),
                    hintStyle: TextStyle(
                      color: AppColors.secondaryHeadTextColor.withOpacity(0.4),
                      fontSize: 14.sp,
                      fontFamily: 'Alexandria',
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    onSubmitted: (value) {
                      if (_hasText) {
                        widget.onSendMessage(value);
                        _controller.clear();
                      }
                    },
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Send button
              GestureDetector(
                onTap: () {
                  if (_hasText) {
                    widget.onSendMessage(_controller.text);
                    _controller.clear();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44.w,
                  height: 44.w,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _hasText
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.3),
                    boxShadow: _hasText
                        ? [
                            BoxShadow(
                              color: Color(0x4D2EAEE0), // #2EAEE04D
                              offset: Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: -4,
                            ),
                            BoxShadow(
                              color: Color(0x4D2EAEE0), // #2EAEE04D
                              offset: Offset(0, 10),
                              blurRadius: 15,
                              spreadRadius: -3,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
