import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';

class GroupListItem extends StatelessWidget {
  final ChatModel chat;

  const GroupListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsRepo.getColors(colorName: "mygrey"),
            foregroundColor: ColorsRepo.getMainColor(),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        onPressed: () {
          Get.toNamed(ScreenName.groupchat, arguments: {'chat': chat});
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(chat.avatarURL ?? ''),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chat.name ?? '',
                          style: StylesRepo.getStyle(style_name: "title"),
                        ),
                        Text(chat.lastMessageDate ?? '',
                            style: StylesRepo.getStyle(style_name: "timestamp"))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(chat.lastMessage ?? '',
                              style:
                                  StylesRepo.getStyle(style_name: "subtitle")),
                          chat.unReadCount! > 0
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Text(
                                    "${chat.unReadCount}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
