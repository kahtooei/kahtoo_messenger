import 'package:flutter/cupertino.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Screens/Message/messageListItem.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';

class MessageListView extends StatelessWidget {
  final List<ChatModel> chatList;
  const MessageListView({required this.chatList, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        return MessageListItem(
          chat: chatList[index],
        );
      },
    );
  }
}
