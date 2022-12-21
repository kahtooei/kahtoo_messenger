import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/API/Http/newChat_service.dart';
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Constants/Config.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';

import '../../Constants/Addresses.dart';
import '../../Storage/Database/dbservices/userservices.dart';

class NewChatGet extends GetxController {
  var isLoading = false.obs;

  startChat(String username) async {
    if (!isLoading.value) {
      isLoading.value = true;
      if (username != Config.myInfo.username) {
        ChatUser user = await NewChatService.checkUsername(username);
        if (user.username!.isNotEmpty) {
          ChatUser chatUser = await UserServices.setOne(
              ChatUser(username: username, name: user.name));
          //dismiss dialog
          Get.back();
          ChatModel chat = ChatModel(
              id: chatUser.id,
              avatarURL:
                  "https://cdn-icons-png.flaticon.com/512/149/149071.png",
              name: chatUser.name,
              username: chatUser.username,
              lastMessage: "",
              lastMessageDate: "");
          Get.toNamed(ScreenName.chat, arguments: {'chat': chat});
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        ShowErrorSnack.show('Your Username', 'This Is Your Username...');
      }
    }
  }
}
