import 'dart:convert';

import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Config.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';

class NewChatService {
  NewChatService._();

  static Future<dynamic> checkUsername(String username) async {
    String myurl = "${AddressRepo.getURL()}/newChat";
    String myurl1 = "${AddressRepo.getURL()}/connect";
    var _url = Uri.parse(myurl);
    var _url1 = Uri.parse(myurl1);
    try {
      var response1 = await http.get(_url1);
      final res = json.decode(response1.body);
      if (res['status'] == "OK") {
        var response = await http.post(_url, body: {
          'username': username,
          'token': Config.myInfo.token,
        });
        final body = json.decode(response.body);
        if (body['statusCode'] == 200) {
          String fullName = body['fullName'];
          return ChatUser(username: username, name: fullName);
        } else if (body['statusCode'] == 401) {
          ShowErrorSnack.show('Invalid Session', 'You Are Logged Out');
          LocalCache.deleteMyInfo();
          Get.offAll(ScreenName.splash);
        } else {
          ShowErrorSnack.show('Incorrect Info', body['error']);
          return ChatUser(username: '');
        }
      } else {
        ShowErrorSnack.show('Not Available', 'Service Not Available');
        return ChatUser(username: '');
      }
    } catch (e) {
      ShowErrorSnack.show('No Internet', 'Internet Connection Fail');
      return ChatUser(username: '');
    }
  }
}
