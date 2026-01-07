import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/features/home/view/widgets/app_bar_main.dart';

import 'widgets/chat_item.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarMain(
        title: 'الرسائل',
        onMenuTap: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: Column(
        children: [
          // Guest messages toast
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: AppColors.white,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.groups_3_outlined,
                            color: AppColors.primaryColor,
                            size: 25.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'رسائل الزوار',
                            style: TextStyle(
                              color: AppColors.secondaryHeadTextColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Alexandria',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "لديك رسائل من زوار الملف الشخصي",
                        style: TextStyle(
                          color: AppColors.secondaryHeadTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Alexandria',
                        ),
                      ),
                      SizedBox(height: 15.h),
                      AppButton(
                        text: "عرض الرسائل",
                        suffixIcon: Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                          size: 25.sp,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Tab Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Container(
              height: 50.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.white.withOpacity(0.8),
                  width: 1.5,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    // colors: [AppColors.g1, AppColors.g2],
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.g1.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                labelColor: AppColors.secondaryHeadTextColor,
                dividerHeight: 0,
                unselectedLabelColor:
                    AppColors.secondaryHeadTextColor.withOpacity(0.5),
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Alexandria',
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Alexandria',
                ),
                tabs: [
                  Tab(
                    icon: Text('الكل'),
                  ),
                  Tab(
                    icon: Text('المجموعات'),
                  ),
                  Tab(
                    icon: Text('الأفراد'),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Tab Bar View
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: TabBarView(
                controller: _tabController,
                children: [
                  // All Chats Tab
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildSectionTitle('المحادثات النشطة'),
                        SizedBox(height: 12.h),
                        ..._buildActiveChats(),
                        SizedBox(height: 24.h),
                        _buildSectionTitle('المحادثات السابقة'),
                        SizedBox(height: 12.h),
                        ..._buildPreviousChats(),
                      ],
                    ),
                  ),

                  // Groups Tab
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._buildGroupChats(),
                      ],
                    ),
                  ),

                  // Single Chats Tab
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._buildIndividualChats(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.secondaryHeadTextColor.withOpacity(0.2),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryHeadTextColor.withOpacity(0.7),
              fontFamily: 'Alexandria',
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.secondaryHeadTextColor.withOpacity(0.2),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActiveChats() {
    return [
      ChatItem(
        title: "فريق الدعم الفني",
        subtitle: "مرحبًا! كيف يمكننا مساعدتك اليوم؟",
        dateTime: "الآن",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "3",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "أحمد محمد",
        subtitle: "شكرًا لك على المساعدة!",
        dateTime: "2 دقيقة",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "1",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "مجموعة الحجاج",
        subtitle: "محمد: نلتقي غدًا في الساعة 10",
        dateTime: "5 دقائق",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "12",
      ),
    ];
  }

  List<Widget> _buildPreviousChats() {
    return [
      ChatItem(
        title: "سارة عبدالله",
        subtitle: "هل يمكنك مساعدتي في تحديد...",
        dateTime: "أمس",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "عبدالرحمن",
        subtitle: "تم استلام المستندات، شكرًا",
        dateTime: "2 يوم",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "فريق الإدارة",
        subtitle: "اجتماع يوم الخميس القادم",
        dateTime: "3 أيام",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "مصطفى الكامل",
        subtitle: "شكرًا على تلبية الطلب",
        dateTime: "أسبوع",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
      ),
    ];
  }

  List<Widget> _buildGroupChats() {
    return [
      ChatItem(
        title: "مجموعة الحجاج 2024",
        subtitle: "محمد: النقاش مستمر حول الموعد",
        dateTime: "الآن",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "8",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "فريق الدعم",
        subtitle: "أحمد: تم حل المشكلة",
        dateTime: "30 دقيقة",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "3",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "متطوعي الزمزم",
        subtitle: "سالم: جدول النوبات الجديد",
        dateTime: "ساعة",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "5",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "مجموعة التعارف",
        subtitle: "خالد: مرحبًا بالجميع",
        dateTime: "2 يوم",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
      ),
    ];
  }

  List<Widget> _buildIndividualChats() {
    return [
      ChatItem(
        title: "فاطمة العتيبي",
        subtitle: "هل يمكنني تغيير موعد الزيارة؟",
        dateTime: "الآن",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "2",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "خالد الرويلي",
        subtitle: "شكرًا على المعلومات القيمة",
        dateTime: "15 دقيقة",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "1",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "نورة القحطاني",
        subtitle: "أرسلت لك الملف المطلوب",
        dateTime: "ساعة",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "محمد الشهري",
        subtitle: "نلتقي غدًا إن شاء الله",
        dateTime: "3 ساعات",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
      ),
    ];
  }
}
