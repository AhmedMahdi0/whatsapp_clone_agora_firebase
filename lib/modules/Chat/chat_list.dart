import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:whatsapp_clone_agora_firebase/modules/Chat/sender_message_card.dart';

import '../../shared/styles/info.dart';
import 'my_message_card.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {  final ScrollController messageController = ScrollController();

@override
void dispose() {
  super.dispose();
  messageController.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageController
              .jumpTo(messageController.position.maxScrollExtent);
        });
        return ListView.builder(
          controller: messageController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            if (messages[index]['isMe'] == true) {
                return MyMessageCard(
                  message: messages[index]['text'].toString(),
                  date: messages[index]['time'].toString(),
                );

            }
            return SenderMessageCard(
                message: messages[index]['text'].toString(),
                date: messages[index]['time'].toString(),

            );
          },
        );
      }
    );
  }
}