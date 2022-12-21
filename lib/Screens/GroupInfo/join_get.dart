import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/API/Http/newChat_service.dart';
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Constants/Config.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';

import '../../Constants/Addresses.dart';
import '../../Storage/Database/dbservices/userservices.dart';

class NewJoinGet extends GetxController {
  var isLoading = false.obs;

  join(String username, String groupname) async {
    if (!isLoading.value) {
      isLoading.value = true;
      if (username != Config.myInfo.username) {
      } else {
        isLoading.value = false;
        ShowErrorSnack.show('Your Username', 'This Is Your Username...');
      }
    }
  }
}
