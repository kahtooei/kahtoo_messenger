import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:kahtoo_messenger/Models/chat_message_model.dart';

class ChatListItem extends StatelessWidget {
  ChatMessageModel chat;
  ChatListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
      text: chat.content!,
      color: chat.isMe! ? Colors.green : Colors.grey,
      tail: true,
      isSender: chat.isMe!,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
