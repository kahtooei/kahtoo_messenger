import 'package:get_storage/get_storage.dart';

class LocalCache {
  LocalCache._();

  static const String usernameKey = "username";
  static const String tokenKey = "token";

  static Future<Map<String, dynamic>> getMyInfo() async {
    Map<String, dynamic> myInfo = {};
    final box = GetStorage();
    myInfo[usernameKey] = await box.read(usernameKey);
    myInfo[tokenKey] = await box.read(tokenKey);
    return myInfo;
  }

  static setMyInfo({required String username, required String token}) async {
    final box = GetStorage();
    await box.write(usernameKey, username);
    await box.write(tokenKey, token);
  }

  static deleteMyInfo() async {
    final box = GetStorage();
    await box.remove(usernameKey);
    await box.remove(tokenKey);
  }
}
