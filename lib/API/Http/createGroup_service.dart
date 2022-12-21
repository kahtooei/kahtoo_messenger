import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatgroup.dart';

class CreateGroupService {
  CreateGroupService._();

  static Future<bool> create(ChatGroup group) async {
    String myurl = "${AddressRepo.getURL()}/createGroup";
    String myurl1 = "${AddressRepo.getURL()}/connect";
    var _url = Uri.parse(myurl);
    var _url1 = Uri.parse(myurl1);
    try {
      MyModel info = await LocalCache.getMyInfo();
      var response1 = await http.get(_url1);
      final res = json.decode(response1.body);
      if (res['status'] == "OK") {
        var response = await http.post(_url, body: {
          'groupname': group.groupname,
          'name': group.name,
          'token': info.token,
        });
        final body = json.decode(response.body);
        if (body['statusCode'] == 200) {
          return true;
        } else {
          ShowErrorSnack.show('Incorrect Info', body['error']);
          return false;
        }
      } else {
        ShowErrorSnack.show('Not Available', 'Service Not Available');
        return false;
      }
    } catch (e) {
      ShowErrorSnack.show('No Internet', 'Internet Connection Fail');
      return false;
    }
  }
}
