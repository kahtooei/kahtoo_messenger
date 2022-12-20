import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Models/chat_message_model.dart';
import 'groupchat_listitem.dart';

class GroupChatListView extends StatelessWidget {
  final List<ChatMessageModel> chats;
  final ScrollController controller;
  const GroupChatListView(
      {super.key, required this.chats, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        controller: controller,
        itemCount: chats.length,
        padding: const EdgeInsets.only(bottom: 70),
        itemBuilder: (context, index) {
          return GroupChatListItem(chat: chats[index]);
        });
  }
}
