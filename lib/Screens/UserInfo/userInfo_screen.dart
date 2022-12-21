import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
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
              "Username : ${chat.username}",
              style: StylesRepo.getStyle(style_name: "title"),
            )
          ],
        ),
      ),
    );
  }
}
