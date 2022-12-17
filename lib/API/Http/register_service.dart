import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';

class RegisterService {
  RegisterService._();

  static Future<dynamic> register(MyModel info) async {
    String myurl = "${AddressRepo.getURL()}/register";
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
          'fullName': info.fullName,
        });
        final body = json.decode(response.body);
        if (body['responseStatus'] == "OK") {
          String token = body['token'];
          return MyModel(
              username: info.username,
              token: token,
              fullName: info.fullName,
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
