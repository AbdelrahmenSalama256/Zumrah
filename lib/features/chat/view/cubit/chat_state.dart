import 'package:zumrah/features/chat/data/models/massage_model.dart';

class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final ChatUser? chatUser;
  final ChatGroup? chatGroup;
  final ChatType chatType;

  const ChatLoaded({
    required this.messages,
    this.chatUser,
    this.chatGroup,
    this.chatType = ChatType.single,
  });
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);
}
