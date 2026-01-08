enum ChatType {
  single,
  group,
}

class ChatUser {
  final String id;
  final String name;
  final String subtitle;
  final String profileImage;
  final bool isOnline;

  ChatUser({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.profileImage,
    required this.isOnline,
  });
}

class ChatGroup {
  final String id;
  final String name;
  final List<ChatUser> members;
  final String? groupImage;
  final String subtitle;
  final int onlineCount;

  ChatGroup({
    required this.id,
    required this.name,
    required this.members,
    this.groupImage,
    this.subtitle = '',
    this.onlineCount = 0,
  });
}

// Extend the Message model to include sender info for groups
class Message {
  final String id;
  final String content;
  final bool isMe;
  final DateTime timestamp;
  final ChatUser? sender; // For group chats
  final String? senderName; // For group chats display

  Message({
    required this.id,
    required this.content,
    required this.isMe,
    required this.timestamp,
    this.sender,
    this.senderName,
  });
}
