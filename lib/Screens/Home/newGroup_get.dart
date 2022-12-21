import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/API/Http/createGroup_service.dart';
import 'package:kahtoo_messenger/API/Http/newChat_service.dart';
import 'package:kahtoo_messenger/API/WS/WebSocketConnect.dart';
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Constants/Config.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatgroup.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/groupservice.dart';

import '../../Constants/Addresses.dart';
import '../../Storage/Database/dbservices/userservices.dart';

class NewGroupGet extends GetxController {
  var isLoading = false.obs;

  createGroup(String groupname, String name) async {
    if (!isLoading.value) {
      isLoading.value = true;
      if (groupname.isNotEmpty && name.isNotEmpty) {
        ChatGroup chatGroup = ChatGroup(groupname: groupname, name: name);
        bool res = await CreateGroupService.create(chatGroup);
        if (res) {
          chatGroup = await GroupServices.setOne(chatGroup);
          ChatModel chat = ChatModel(
              id: chatGroup.id,
              name: name,
              username: groupname,
              lastMessage: "",
              lastMessageDate: "",
              unReadCount: 0,
              avatarURL: "https://cdn-icons-png.flaticon.com/512/25/25437.png");
          WebSocketConnect.addToGroup(groupname);
          Get.back();
          Get.toNamed(ScreenName.groupchat, arguments: {'chat': chat});
          WebSocketConnect.msgStreamController.sink.add({"type": "newGroup"});
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      ShowErrorSnack.show('Empty Field', 'Enter Name And Groupname...');
    }
  }
}
