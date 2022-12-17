import 'package:get_storage/get_storage.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';

class LocalCache {
  LocalCache._();

  static const String usernameKey = "username";
  static const String tokenKey = "token";
  static const String fullNameKey = "fullName";
  static const String passwordKey = "password";

  static Future<MyModel> getMyInfo() async {
    MyModel info = MyModel();
    final box = GetStorage();
    info.username = box.read(usernameKey);
    info.token = box.read(tokenKey);
    info.fullName = box.read(fullNameKey);
    info.password = box.read(passwordKey);
    return info;
  }

  static setMyInfo(MyModel info) async {
    final box = GetStorage();
    await box.write(usernameKey, info.username);
    await box.write(tokenKey, info.token);
    await box.write(fullNameKey, info.fullName);
    await box.write(passwordKey, info.password);
  }

  static deleteMyInfo() async {
    final box = GetStorage();
    await box.remove(usernameKey);
    await box.remove(tokenKey);
    await box.remove(fullNameKey);
    await box.remove(passwordKey);
  }
}
