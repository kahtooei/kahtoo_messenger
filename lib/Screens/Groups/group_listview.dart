import 'package:flutter/cupertino.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Screens/Message/messageListItem.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';

import 'group_listitem.dart';

class GroupListView extends StatelessWidget {
  final List<ChatModel> groupchatList;
  const GroupListView({required this.groupchatList, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groupchatList.length,
      itemBuilder: (context, index) {
        return GroupListItem(
          chat: groupchatList[index],
        );
      },
    );
  }
}
