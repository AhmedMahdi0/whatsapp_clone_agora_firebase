
import '../../../shared/components/compoents.dart';

abstract class ChatState {}


class InitialState extends ChatState {}


class GetChatContacts extends ChatState {}

class GetChatGroups extends ChatState {}

class GetChatMessage extends ChatState {}

class GetGroupChatMessage extends ChatState {}

class SendMessageSuccessState extends ChatState {}

class SendMessageErrorState extends ChatState {}

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(this.message, this.isMe, this.messageEnum);
}

