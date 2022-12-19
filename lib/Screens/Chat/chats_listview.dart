import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Models/chat_message_model.dart';
import 'package:kahtoo_messenger/Screens/Chat/chats_listitem.dart';

class ChatsListView extends StatelessWidget {
  final List<ChatMessageModel> chats;
  final ScrollController controller;
  const ChatsListView(
      {super.key, required this.chats, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        controller: controller,
        itemCount: chats.length,
        padding: const EdgeInsets.only(bottom: 70),
        itemBuilder: (context, index) {
          return ChatListItem(chat: chats[index]);
        });
  }
}
