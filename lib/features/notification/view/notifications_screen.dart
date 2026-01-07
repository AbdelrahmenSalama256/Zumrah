import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      onTap: () {},
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
}
