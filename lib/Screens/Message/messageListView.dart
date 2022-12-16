import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';

class MessageListView extends StatelessWidget {
  final List<ChatUser> userList;
  const MessageListView({required this.userList, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return MessageView(user: userList[index]);
      },
    );
  }
}

class MessageView extends StatelessWidget {
  final ChatUser user;
  const MessageView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(user.name!),
          Text(user.username!),
        ],
      ),
    );
  }
}
