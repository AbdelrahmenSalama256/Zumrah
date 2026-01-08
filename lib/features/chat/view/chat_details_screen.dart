import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zumrah/core/constants/custom_scaffold.dart';
import 'package:zumrah/core/locale/app_loacl.dart'; // Add this import

import '../../../core/constants/app_colors.dart';
import '../../home/view/widgets/app_bar_main.dart';
import '../data/models/massage_model.dart';
import './widgets/chat_header.dart';
import './widgets/chat_input_field.dart';
import './widgets/message_bubble.dart';
import 'cubit/chat_cubit.dart';
import 'cubit/chat_state.dart';

class ChatDetailsScreen extends StatefulWidget {
  final ChatType chatType;
  final ChatUser? chatUser;
  final ChatGroup? chatGroup;

  const ChatDetailsScreen({
    super.key,
    this.chatType = ChatType.single,
    this.chatUser,
    this.chatGroup,
  }) : assert(
          (chatType == ChatType.single && chatUser != null) ||
              (chatType == ChatType.group && chatGroup != null) ||
              (chatUser == null && chatGroup == null),
          'Provide appropriate data based on chat type',
        );

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatType = widget.chatType;
    final chatUser = widget.chatUser;
    final chatGroup = widget.chatGroup;

    // Fallback data to keep UI working even if caller omits chat info.
    final fallbackUser = ChatUser(
      id: 'demo-user',
      name: 'chat_details_title_single'.tr(context),
      subtitle: 'chat_details_online'.tr(context),
      profileImage: 'assets/images/png/avatar.png',
      isOnline: true,
    );

    final fallbackGroup = ChatGroup(
      id: 'demo-group',
      name: 'chat_details_title_group'.tr(context),
      members: [fallbackUser],
      subtitle: '${fallbackUser.name} ${'chat_details_members'.tr(context)}',
      onlineCount: 1,
    );

    final effectiveUser =
        chatType == ChatType.single ? (chatUser ?? fallbackUser) : fallbackUser;
    final effectiveGroup =
        chatType == ChatType.group ? (chatGroup ?? fallbackGroup) : null;
    final chatId = chatType == ChatType.single
        ? effectiveUser.id
        : (effectiveGroup ?? fallbackGroup).id;

    return CustomScaffold(
      body: BlocProvider(
        create: (context) => ChatCubit(
          chatType: chatType,
          chatId: chatId,
          chatUser: chatType == ChatType.single ? effectiveUser : null,
          chatGroup: chatType == ChatType.group ? effectiveGroup : null,
        )..loadMessages(),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                AppBarMain(
                  title: chatType == ChatType.single
                      ? 'chat_details_title_single'.tr(context)
                      : 'chat_details_title_group'.tr(context),
                ),
                ChatHeader(
                  chatType: chatType,
                  chatUser: chatType == ChatType.single ? effectiveUser : null,
                  chatGroup: chatType == ChatType.group ? effectiveGroup : null,
                  onBackPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: BlocListener<ChatCubit, ChatState>(
                    listener: (context, state) {
                      if (state is ChatLoaded) {
                        _scrollToBottom();
                      }
                    },
                    child: BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        if (state is ChatLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'chat_details_loading'.tr(context),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.secondaryHeadTextColor
                                        .withOpacity(0.6),
                                    fontFamily: 'Alexandria',
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is ChatLoaded) {
                          if (state.messages.isEmpty) {
                            return Center(
                              child: Text(
                                'chat_details_no_messages'.tr(context),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.secondaryHeadTextColor
                                      .withOpacity(0.5),
                                  fontFamily: 'Alexandria',
                                ),
                              ),
                            );
                          }
                          return SingleChildScrollView(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                ...state.messages.map(
                                  (message) => MessageBubble(
                                    message: message,
                                    chatType: state.chatType,
                                    showSenderName:
                                        state.chatType == ChatType.group,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          );
                        } else if (state is ChatError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 48.sp,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'chat_details_error'
                                      .tr(context)
                                      .replaceAll('{error}', state.message),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.red,
                                    fontFamily: 'Alexandria',
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<ChatCubit>().loadMessages();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  child: Text(
                                      'chat_details_try_again'.tr(context)),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
                Builder(
                  builder: (innerContext) {
                    return BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        return ChatInputField(
                          onSendMessage: (message) {
                            context.read<ChatCubit>().sendMessage(message);
                          },
                          chatType: chatType,
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
