import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../Layout/Cubit/group.dart';
import '../../../models/chat_contact.dart';
import '../../../models/message.dart';
import '../../../models/user_model.dart';
import '../../../shared/components/compoents.dart';
import 'ChatStateBloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(InitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  Future<void> getChatContacts() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .listen((event) async {
      List<ChatContact> contacts = [];
      event.docs.forEach((element) {
        contacts.add(ChatContact.fromMap(element.data()));
      });
      emit(GetChatContacts());
    });
  }

  Future<void> getChatGroups() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('groups')
        .snapshots()
        .listen((event) {
      List<Group> groups = [];
      event.docs.forEach((element) {
        groups.add(Group.fromMap(element.data()));
      });
      emit(GetChatGroups());
    });
  }

  Future<void> getChatMessage(String recieverUserId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .listen((event) {
      List<Message> messages = [];
      event.docs.forEach((element) {
        messages.add(Message.fromMap(element.data()));
      });
      emit(GetChatMessage());
    });
  }

  Future<void> getGroupChatMessage(String groudId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('groups')
        .doc(groudId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .listen((event) {
      List<Message> messages = [];
      event.docs.forEach((element) {
        messages.add(Message.fromMap(element.data()));
      });
      emit(GetGroupChatMessage());
    });
  }

//   void _saveDataToContactsSubcollection(
//       UserModel senderUserData,
//       UserModel? recieverUserData,
//       String text,
//       DateTime timeSent,
//       String recieverUserId,
//       bool isGroupChat,
//       ) async {
//     if (isGroupChat) {
//       await FirebaseFirestore.instance.collection('groups').doc(recieverUserId).update({
//         'lastMessage': text,
//         'timeSent': DateTime.now().millisecondsSinceEpoch,
//       });
//     } else {
// // users -> reciever user id => chats -> current user id -> set data
//       var recieverChatContact = ChatContact(
//         name: senderUserData.name,
//         profilePic: senderUserData.profilePic,
//         contactId: senderUserData.uid,
//         timeSent: timeSent,
//         lastMessage: text,
//       );
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(recieverUserId)
//           .collection('chats')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .set(
//         recieverChatContact.toMap(),
//       );
//       // users -> current user id  => chats -> reciever user id -> set data
//       var senderChatContact = ChatContact(
//         name: recieverUserData!.name,
//         profilePic: recieverUserData.profilePic,
//         contactId: recieverUserData.uid,
//         timeSent: timeSent,
//         lastMessage: text,
//       );
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('chats')
//           .doc(recieverUserId)
//           .set(
//         senderChatContact.toMap(),
//       );
//     }
//   }
//
//   void _saveMessageToMessageSubcollection({
//     required String recieverUserId,
//     required String text,
//     required DateTime timeSent,
//     required String messageId,
//     required String username,
//     required MessageEnum messageType,
//     required MessageReply? messageReply,
//     required String senderUsername,
//     required String? recieverUserName,
//     required bool isGroupChat,
//   }) async {
//     final message = Message(
//       senderId: FirebaseAuth.instance.currentUser!.uid,
//       recieverid: recieverUserId,
//       text: text,
//       type: messageType,
//       timeSent: timeSent,
//       messageId: messageId,
//       isSeen: false,
//       repliedMessage: messageReply == null ? '' : messageReply.message,
//       repliedTo: messageReply == null
//           ? ''
//           : messageReply.isMe
//           ? senderUsername
//           : recieverUserName ?? '',
//       repliedMessageType:
//       messageReply == null ? MessageEnum.text : messageReply.messageEnum,
//     );
//     if (isGroupChat) {
//       // groups -> group id -> chat -> message
//       await FirebaseFirestore.instance
//           .collection('groups')
//           .doc(recieverUserId)
//           .collection('chats')
//           .doc(messageId)
//           .set(
//         message.toMap(),
//       );
//     } else {
//       // users -> sender id -> reciever id -> messages -> message id -> store message
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('chats')
//           .doc(recieverUserId)
//           .collection('messages')
//           .doc(messageId)
//           .set(
//         message.toMap(),
//       );
//       // users -> eciever id  -> sender id -> messages -> message id -> store message
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(recieverUserId)
//           .collection('chats')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('messages')
//           .doc(messageId)
//           .set(
//         message.toMap(),
//       );
//     }
//   }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
    MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();
    Message model = Message(senderId: FirebaseAuth.instance.currentUser!.uid,
        recieverid: recieverUserId,
        text: text,
        type: MessageEnum.text,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: messageReply!.isMe,
        repliedMessage: messageReply!.message,
        repliedMessageType: messageReply!.messageEnum);
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messges')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messges')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();

    String imageUrl = await ref
        .read(commonFirebaseStorageRepositoryProvider)
        .storeFileToFirebase(
      'chat/${messageEnum.type}/${senderUserData
          .uid}/$recieverUserId/$messageId',
      file,
    );

    // UserModel? recieverUserData;
    // if (!isGroupChat) {
    //   var userDataMap =
    //   await FirebaseFirestore.instance.collection('users').doc(recieverUserId).get();
    //   recieverUserData = UserModel.fromMap(userDataMap.data()!);
    // }

    String contactMsg;

    switch (messageEnum) {
      case MessageEnum.image:
        contactMsg = '📷 Photo';
        break;
      case MessageEnum.video:
        contactMsg = '📸 Video';
        break;
      case MessageEnum.audio:
        contactMsg = '🎵 Audio';
        break;
      case MessageEnum.gif:
        contactMsg = 'GIF';
        break;
      default:
        contactMsg = 'GIF';
    }
    Message model = Message(senderId: FirebaseAuth.instance.currentUser!.uid,
        recieverid: recieverUserId,
        text: imageUrl,
        type: messageEnum, timeSent: timeSent, messageId: messageId,
        isSeen: messageReply!.isMe, repliedMessage: messageReply.message,
        repliedMessageType: messageReply.messageEnum);
    Message model2 = Message(senderId: FirebaseAuth.instance.currentUser!.uid,
        recieverid: recieverUserId,
        text: contactMsg,
        type: messageEnum, timeSent: timeSent, messageId: messageId,
        isSeen: messageReply.isMe, repliedMessage: messageReply.message,
        repliedMessageType: messageReply.messageEnum);

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messges')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messges')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(model2.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(model2.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {

      var timeSent = DateTime.now();
      UserModel? recieverUserData;
      var messageId = const Uuid().v1();

      Message model = Message(senderId: FirebaseAuth.instance.currentUser!.uid,
          recieverid: recieverUserId,
          text: gifUrl,
          type: MessageEnum.gif, timeSent: timeSent, messageId: messageId,
          isSeen: messageReply!.isMe, repliedMessage: messageReply.message,
          repliedMessageType: messageReply.messageEnum);
      Message model2 = Message(senderId: FirebaseAuth.instance.currentUser!.uid,
          recieverid: recieverUserId,
          text: 'GIF',
          type: MessageEnum.gif, timeSent: timeSent, messageId: messageId,
          isSeen: messageReply.isMe, repliedMessage: messageReply.message,
          repliedMessageType: messageReply.messageEnum);
      FirebaseFirestore.instance
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messges')
          .add(model.toMap())
          .then((value) {
        emit(SendMessageSuccessState());
      }).catchError((error) {
        emit(SendMessageErrorState());
      });

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messges')
          .add(model.toMap())
          .then((value) {
        emit(SendMessageSuccessState());
      }).catchError((error) {
        emit(SendMessageErrorState());
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .set(model2.toMap())
          .then((value) {
        emit(SendMessageSuccessState());
      }).catchError((error) {
        emit(SendMessageErrorState());
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(model2.toMap())
          .then((value) {
        emit(SendMessageSuccessState());
      }).catchError((error) {
        emit(SendMessageErrorState());
      });



  }

  void setChatMessageSeen(BuildContext context,
      String recieverUserId,
      String messageId,) async {

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});

      await FirebaseFirestore.instance
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true}).then((value) {
        emit(SendMessageSuccessState());
      }).catchError((error) {
        emit(SendMessageErrorState());
      });

  }
}
