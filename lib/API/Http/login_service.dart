import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';

class LoginService {
  LoginService._();

  static Future<dynamic> login(MyModel info) async {
    String myurl = "${AddressRepo.getURL()}/login";
    String myurl1 = "${AddressRepo.getURL()}/connect";
    var _url = Uri.parse(myurl);
    var _url1 = Uri.parse(myurl1);
    try {
      var response1 = await http.get(_url1);
      final res = json.decode(response1.body);
      if (res['status'] == "OK") {
        var response = await http.post(_url, body: {
          'username': info.username,
          'password': info.password,
        });
        final body = json.decode(response.body);
        if (body['responseStatus'] == "OK") {
          String token = body['token'];
          String fullName = body['token'];
          return MyModel(
              username: info.username,
              token: token,
              fullName: fullName,
              password: info.password);
        } else {
          ShowErrorSnack.show(
              'Incorrect Info', 'Username Or Password Incorrect');
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
