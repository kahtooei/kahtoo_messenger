import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_textbutton.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Screens/GroupInfo/joinUserGroup_dialog.dart';

import '../../Constants/Styles.dart';

class GroupInfo extends StatefulWidget {
  const GroupInfo({super.key});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  late final ChatModel chat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var args = Get.arguments;
    chat = args['chat'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(chat.avatarURL ?? ''),
                  ),
                ),
              ),
            ),
            Text(
              "Name : ${chat.name}",
              style: StylesRepo.getStyle(style_name: "title"),
            ),
            Text(
              "Groupname : ${chat.username}",
              style: StylesRepo.getStyle(style_name: "title"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Group Users",
                    style: StylesRepo.getStyle(style_name: "H1"),
                  ),
                  MainTextButton(
                    text: "Add User",
                    onClicked: addUserToGroup,
                    textColor: ColorsRepo.getMainColor(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addUserToGroup() {
    Get.dialog(
      JoinUserGroupDialog(groupname: chat.username!),
    );
  }
}
