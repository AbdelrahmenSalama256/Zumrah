import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/component/widgets/app_button.dart';
import 'package:zumrah/core/constants/app_colors.dart';
import 'package:zumrah/core/constants/navigation.dart';
import 'package:zumrah/core/locale/app_loacl.dart';
import 'package:zumrah/features/chat/view/chat_details_screen.dart';
import 'package:zumrah/features/home/view/widgets/app_bar_main.dart';

import '../data/models/massage_model.dart';
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
        title: 'chat_title'.tr(context),
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
                            'chat_guest_messages'.tr(context),
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
                        'chat_guest_messages_desc'.tr(context),
                        style: TextStyle(
                          color: AppColors.secondaryHeadTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Alexandria',
                        ),
                      ),
                      SizedBox(height: 15.h),
                      AppButton(
                        text: 'chat_view_messages'.tr(context),
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
                    text: 'chat_tab_all'.tr(context),
                  ),
                  Tab(
                    text: 'chat_tab_groups'.tr(context),
                  ),
                  Tab(
                    text: 'chat_tab_individuals'.tr(context),
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
                        _buildSectionTitle('chat_section_active'.tr(context)),
                        SizedBox(height: 12.h),
                        ..._buildActiveChats(),
                        SizedBox(height: 24.h),
                        _buildSectionTitle('chat_section_previous'.tr(context)),
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
      // Group chat example
      ChatItem(
        title: "فريق الدعم الفني",
        subtitle: "مرحبًا! كيف يمكننا مساعدتك اليوم؟",
        dateTime: 'chat_now'.tr(context),
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "3",
        isGroup: true,
        onTap: () {
          _navigateToGroupChat(
            'فريق الدعم الفني',
            ['علي', 'محمد', 'فاطمة', 'خالد'],
          );
        },
      ),
      SizedBox(height: 10.h),
      // Single chat example
      ChatItem(
        title: "أحمد محمد",
        subtitle: "شكرًا لك على المساعدة!",
        dateTime: "2 ${'chat_minutes_ago'.tr(context)}",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "1",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('أحمد محمد');
        },
      ),
      SizedBox(height: 10.h),
      // Group chat example
      ChatItem(
        title: "مجموعة الحجاج",
        subtitle: "محمد: نلتقي غدًا في الساعة 10",
        dateTime: "5 ${'chat_minutes_ago'.tr(context)}",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "12",
        isGroup: true,
        onTap: () {
          _navigateToGroupChat(
            'مجموعة الحجاج',
            ['سالم', 'نورة', 'ماجد', 'هدى', 'ياسر'],
          );
        },
      ),
    ];
  }

  List<Widget> _buildPreviousChats() {
    return [
      ChatItem(
        title: "سارة عبدالله",
        subtitle: "هل يمكنك مساعدتي في تحديد...",
        dateTime: 'chat_yesterday'.tr(context),
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('سارة عبدالله');
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "عبدالرحمن",
        subtitle: "تم استلام المستندات، شكرًا",
        dateTime: "2 ${'chat_days_ago'.tr(context)}",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('عبدالرحمن');
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "فريق الإدارة",
        subtitle: "اجتماع يوم الخميس القادم",
        dateTime: "3 ${'chat_days_ago'.tr(context)}",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
        isGroup: true,
        onTap: () {
          _navigateToGroupChat(
              'فريق الإدارة', ['المدير', 'نائب المدير', 'المشرفين']);
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "مصطفى الكامل",
        subtitle: "شكرًا على تلبية الطلب",
        dateTime: 'chat_week_ago'.tr(context),
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('مصطفى الكامل');
        },
      ),
    ];
  }

  List<Widget> _buildGroupChats() {
    return [
      ChatItem(
        title: "مجموعة الحجاج 2024",
        subtitle: "محمد: النقاش مستمر حول الموعد",
        dateTime: 'chat_now'.tr(context),
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "8",
        isGroup: true,
        onTap: () {
          _navigateToGroupChat(
            'مجموعة الحجاج 2024',
            ['عمر', 'ريم', 'فهد', 'لولوة', 'تركي'],
          );
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "فريق الدعم",
        subtitle: "أحمد: تم حل المشكلة",
        dateTime: "30 ${'chat_minutes_ago'.tr(context)}",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "3",
        isGroup: true,
        onTap: () {
          _navigateToGroupChat('فريق الدعم', ['أحمد', 'محمد', 'سعيد', 'ناصر']);
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "متطوعي الزمزم",
        subtitle: "سالم: جدول النوبات الجديد",
        dateTime: 'chat_hour_ago'.tr(context),
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "5",
        isGroup: true,
        onTap: () {
          _navigateToGroupChat(
              'متطوعي الزمزم', ['سالم', 'مشعل', 'منى', 'بدر', 'جواهر']);
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "مجموعة التعارف",
        subtitle: "خالد: مرحبًا بالجميع",
        dateTime: "2 ${'chat_days_ago'.tr(context)}",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
        isGroup: true,
        onTap: () {
          _navigateToGroupChat(
              'مجموعة التعارف', ['خالد', 'نوف', 'فيصل', 'هناء']);
        },
      ),
    ];
  }

  List<Widget> _buildIndividualChats() {
    return [
      ChatItem(
        title: "فاطمة العتيبي",
        subtitle: "هل يمكنني تغيير موعد الزيارة؟",
        dateTime: 'chat_now'.tr(context),
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "2",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('فاطمة العتيبي');
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "خالد الرويلي",
        subtitle: "شكرًا على المعلومات القيمة",
        dateTime: "15 ${'chat_minutes_ago'.tr(context)}",
        isOnline: true,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "1",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('خالد الرويلي');
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "نورة القحطاني",
        subtitle: "أرسلت لك الملف المطلوب",
        dateTime: 'chat_hour_ago'.tr(context),
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('نورة القحطاني');
        },
      ),
      SizedBox(height: 10.h),
      ChatItem(
        title: "محمد الشهري",
        subtitle: "نلتقي غدًا إن شاء الله",
        dateTime: "3 ${'chat_hours_ago'.tr(context)}",
        isOnline: false,
        avatarUrl: 'assets/images/png/avatar.png',
        unreadCount: "0",
        isGroup: false,
        onTap: () {
          _navigateToSingleChat('محمد الشهري');
        },
      ),
    ];
  }

  void _navigateToSingleChat(String userName) {
    navigateTo(
      context,
      ChatDetailsScreen(
        chatType: ChatType.single,
        chatUser: ChatUser(
          id: 'user_${userName.hashCode}',
          name: userName,
          subtitle: 'chat_online_now'.tr(context),
          profileImage: 'assets/images/png/avatar.png',
          isOnline: true,
        ),
      ),
    );
  }

  void _navigateToGroupChat(String groupName, List<String> memberNames) {
    final members = memberNames.map((name) {
      return ChatUser(
        id: 'member_${name.hashCode}',
        name: name,
        subtitle: 'chat_member'.tr(context),
        profileImage: 'assets/images/png/avatar.png',
        isOnline: name == memberNames.first,
      );
    }).toList();

    navigateTo(
      context,
      ChatDetailsScreen(
        chatType: ChatType.group,
        chatGroup: ChatGroup(
          id: 'group_${groupName.hashCode}',
          name: groupName,
          members: members,
          subtitle:
              '${members.length} ${'chat_members'.tr(context)} • ${members.where((m) => m.isOnline).length} ${'chat_online_now'.tr(context)}',
          onlineCount: members.where((m) => m.isOnline).length,
        ),
      ),
    );
  }
}
