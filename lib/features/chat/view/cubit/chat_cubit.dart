import 'package:bloc/bloc.dart';
import 'package:zumrah/features/chat/data/models/massage_model.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatType chatType;
  final String chatId;
  final ChatUser? chatUser;
  final ChatGroup? chatGroup;

  ChatCubit({
    this.chatType = ChatType.single,
    required this.chatId,
    this.chatUser,
    this.chatGroup,
  }) : super(const ChatInitial());

  Future<void> loadMessages() async {
    try {
      emit(const ChatLoading());

      // Simulate loading delay
      await Future.delayed(const Duration(milliseconds: 500));

      final messages = chatType == ChatType.single
          ? await _loadSingleChatMessages()
          : await _loadGroupChatMessages();

      emit(ChatLoaded(
        messages: messages,
        chatUser: chatUser,
        chatGroup: chatGroup,
        chatType: chatType,
      ));
    } catch (e) {
      emit(ChatError('حدث خطأ ما: $e'));
    }
  }

  Future<List<Message>> _loadSingleChatMessages() async {
    // Single chat messages
    return [
      Message(
        id: '1',
        content: 'السلام عليكم، كيف حالك؟',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Message(
        id: '2',
        content: 'وعليكم السلام، الحمد لله تمام التمام',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      Message(
        id: '3',
        content: 'وكيف حالك أنت؟ هل كل شيء بخير؟',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      Message(
        id: '4',
        content: 'تمام الحمد لله، شكراً على السؤال',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
    ];
  }

  Future<List<Message>> _loadGroupChatMessages() async {
    // Group chat messages with sender info
    final members = [
      ChatUser(
        id: '1',
        name: 'محمد إقبال',
        subtitle: 'متصل الآن',
        profileImage: 'assets/images/png/avatar.png',
        isOnline: true,
      ),
      ChatUser(
        id: '2',
        name: 'أحمد محمد',
        subtitle: 'آخر ظهور قبل ساعة',
        profileImage: 'assets/images/png/avatar.png',
        isOnline: false,
      ),
    ];

    return [
      Message(
        id: '1',
        content: 'السلام عليكم جميعاً',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        sender: members[0],
        senderName: members[0].name,
      ),
      Message(
        id: '2',
        content: 'وعليكم السلام ورحمة الله',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      Message(
        id: '3',
        content: 'كيف حالكم جميعاً؟',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
        sender: members[1],
        senderName: members[1].name,
      ),
      Message(
        id: '4',
        content: 'الحمد لله، أنا تمام',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        sender: members[0],
        senderName: members[0].name,
      ),
    ];
  }

  Future<void> sendMessage(String content) async {
    final state = this.state;
    if (state is! ChatLoaded) return;

    try {
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        isMe: true,
        timestamp: DateTime.now(),
      );

      final updatedMessages = [...state.messages, newMessage];
      emit(ChatLoaded(
        messages: updatedMessages,
        chatUser: state.chatUser,
        chatGroup: state.chatGroup,
        chatType: state.chatType,
      ));

      // Simulate receiving a reply after 1 second
      if (state.chatType == ChatType.single) {
        await _simulateSingleChatReply(state, updatedMessages);
      } else {
        await _simulateGroupChatReply(state, updatedMessages);
      }
    } catch (e) {
      emit(ChatError('فشل إرسال الرسالة: $e'));
    }
  }

  Future<void> _simulateSingleChatReply(
      ChatLoaded state, List<Message> updatedMessages) async {
    await Future.delayed(const Duration(seconds: 1));

    final replyMessage = Message(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      content: 'شكراً على رسالتك',
      isMe: false,
      timestamp: DateTime.now(),
    );

    final finalMessages = [...updatedMessages, replyMessage];
    emit(ChatLoaded(
      messages: finalMessages,
      chatUser: state.chatUser,
      chatGroup: state.chatGroup,
      chatType: state.chatType,
    ));
  }

  Future<void> _simulateGroupChatReply(
      ChatLoaded state, List<Message> updatedMessages) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simulate different group members replying
    final members = [
      ChatUser(
        id: '1',
        name: 'محمد إقبال',
        subtitle: 'متصل الآن',
        profileImage: 'assets/images/png/avatar.png',
        isOnline: true,
      ),
      ChatUser(
        id: '2',
        name: 'أحمد محمد',
        subtitle: 'آخر ظهور قبل ساعة',
        profileImage: 'assets/images/png/avatar.png',
        isOnline: false,
      ),
    ];

    final randomMember = members[DateTime.now().second % members.length];
    final replyMessage = Message(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      content: 'جميل!',
      isMe: false,
      timestamp: DateTime.now(),
      sender: randomMember,
      senderName: randomMember.name,
    );

    final finalMessages = [...updatedMessages, replyMessage];
    emit(ChatLoaded(
      messages: finalMessages,
      chatUser: state.chatUser,
      chatGroup: state.chatGroup,
      chatType: state.chatType,
    ));
  }

  // New method to add member to group
  Future<void> addMemberToGroup(ChatUser newMember) async {
    final state = this.state;
    if (state is! ChatLoaded || state.chatType != ChatType.group) return;

    try {
      final updatedGroup = ChatGroup(
        id: state.chatGroup!.id,
        name: state.chatGroup!.name,
        members: [...state.chatGroup!.members, newMember],
        groupImage: state.chatGroup!.groupImage,
        subtitle: state.chatGroup!.subtitle,
        onlineCount: state.chatGroup!.onlineCount,
      );

      emit(ChatLoaded(
        messages: state.messages,
        chatUser: state.chatUser,
        chatGroup: updatedGroup,
        chatType: state.chatType,
      ));
    } catch (e) {
      emit(ChatError('فشل إضافة العضو: $e'));
    }
  }
}
