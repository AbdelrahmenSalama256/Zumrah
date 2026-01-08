import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/notification/view/widgets/notification_card.dart';

import '../../home/view/widgets/app_bar_main.dart';
import 'widgets/notifications_filters.dart';

enum NotifFilter { all, unread, important, system }

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotifFilter _filter = NotifFilter.all;
  int get _allCount => _items.length;
  int get _unreadCount => _items.where((e) => e["isunread"] == true).length;
  int get _importantCount =>
      _items.where((e) => e["type"] == "important").length;
  int get _systemCount => _items.where((e) => e["type"] == "system").length;

  // Demo data (replace with your bloc/api list)
  final List<Map<String, dynamic>> _items = [
    {
      "title": "مهمة جديدة",
      "desc": "تم إضافة مهمة جديدة لك",
      "time": "10:30",
      "type": "task",
      "isunread": true,
    },
    {
      "title": "تنبيه مهم",
      "desc": "يرجى مراجعة البيانات",
      "time": "09:10",
      "type": "important",
      "isunread": true,
    },
    {
      "title": "إشعار نظام",
      "desc": "تم تحديث التطبيق",
      "time": "أمس",
      "type": "system",
      "isunread": false,
    },
  ];

  List<Map<String, dynamic>> get _filteredItems {
    switch (_filter) {
      case NotifFilter.all:
        return _items;

      case NotifFilter.unread:
        return _items.where((e) => (e["isunread"] == true)).toList();

      case NotifFilter.important:
        return _items.where((e) => (e["type"] == "important")).toList();

      case NotifFilter.system:
        return _items.where((e) => (e["type"] == "system")).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: false,
      extendBody: false,
      body: Column(
        children: [
          AppBarMain(
            title: 'notifications'.tr(context),
          ),

          // ✅ Filters tabs
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
            child: NotificationFilters(
              selected: _filter,
              onChanged: (v) => setState(() => _filter = v),
              counts: {
                NotifFilter.all: _allCount,
                NotifFilter.unread: _unreadCount,
                NotifFilter.important: _importantCount,
                NotifFilter.system: _systemCount,
              },
            ),
          ),
          SizedBox(height: 20.h),
          // ✅ list
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
              child: Column(
                children: [
                  for (final n in _filteredItems) ...[
                    NotificationCard(
                      title: n["title"],
                      desc: n["desc"],
                      time: n["time"],
                      type: n["type"],
                      isunread: n["isunread"] as bool,
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle:
                              false, // We'll create our own custom drag handle
                          enableDrag: true,
                          barrierColor: Colors.transparent,
                          isDismissible: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => buildNotificationDetails(ctx, n),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationDetails(
      BuildContext context, Map<String, dynamic> notification) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          snap: true,
          snapSizes: const [0.6, 0.9],
          builder: (context, scrollController) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.95),
                      Colors.white.withOpacity(0.98),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Custom Gradient Drag Handle
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: Container(
                          width: 60.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.g1, AppColors.g2],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.g1.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Notification Type Indicator
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          _buildNotificationTypeIndicator(notification["type"]),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              _getTypeTitle(notification["type"]),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: _getTypeColor(notification["type"]),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              notification["time"],
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        notification["title"],
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              child: Text(
                                notification["desc"],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              ),
                            ),

                            SizedBox(height: 30.h),

                            // Additional Details (simulated)
                            if (notification["type"] == "task") ...[
                              _buildDetailRow(
                                icon: Icons.calendar_today,
                                label: "تاريخ المهمة",
                                value: "اليوم - 10:30 صباحاً",
                              ),
                              SizedBox(height: 12.h),
                              _buildDetailRow(
                                icon: Icons.person,
                                label: "المسؤول",
                                value: "فريق الإدارة",
                              ),
                            ] else if (notification["type"] == "important") ...[
                              _buildDetailRow(
                                icon: Icons.warning_amber,
                                label: "مستوى الأهمية",
                                value: "عالي",
                              ),
                            ],

                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),

                    // Action Buttons
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 30.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(
                                  color: AppColors.g1.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "close".tr(context),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.g1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                gradient: LinearGradient(
                                  colors: [AppColors.g1, AppColors.g2],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.g1.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // Mark as read or take action
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  notification["isunread"]
                                      ? "mark_read".tr(context)
                                      : "view_action".tr(context),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationTypeIndicator(String type) {
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: _getTypeColor(type).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Icon(
          _getTypeIcon(type),
          size: 18.sp,
          color: _getTypeColor(type),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "important":
        return Colors.orange;
      case "system":
        return Colors.blue;
      case "task":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "important":
        return Icons.warning;
      case "system":
        return Icons.system_update;
      case "task":
        return Icons.task;
      default:
        return Icons.notifications;
    }
  }

  String _getTypeTitle(String type) {
    switch (type) {
      case "important":
        return "تنبيه مهم";
      case "system":
        return "إشعار نظام";
      case "task":
        return "مهمة";
      default:
        return "إشعار";
    }
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.g1.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 20.sp,
                color: AppColors.g1,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
