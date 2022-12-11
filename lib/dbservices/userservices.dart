import 'package:kahtoo_messenger/dbmodels/chatuser.dart';
import 'package:kahtoo_messenger/dbhelper/userhelper.dart';

class UserServices {
  static Future<bool> setAll(List<ChatUser> chatUsers) async {
    try {
      var db = ChatHelper();
      await db.open();
      await db.insertAll(chatUsers);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<ChatUser> setOne(ChatUser chatUser) async {
    ChatUser createdUser = ChatUser(id: -1, name: "", username: "");
    try {
      var db = ChatHelper();
      await db.open();
      bool hasChat = await db.hasChatUsername(chatUser.username!);
      if (hasChat) {
        createdUser = await getChatUserByUsername(chatUser.username!);
      } else {
        createdUser = await db.insert(chatUser);
      }

      await db.close();
      return createdUser;
    } catch (e) {
      return createdUser;
    }
  }

  static Future<bool> updateName(ChatUser chatUser) async {
    try {
      var db = ChatHelper();
      await db.open();
      await db.updateName(chatUser);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasUsername(String _username) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.hasChatUsername(_username);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasUserID(int _id) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.hasChatUserID(_id);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<ChatUser> getChatUserByUsername(String _username) async {
    try {
      var db = ChatHelper();
      await db.open();
      ChatUser chatUser = await db.selectByUsername(_username);
      await db.close();
      return chatUser;
    } catch (e) {
      print("Error : ${e.toString()}");
      return ChatUser(id: -1, name: "", username: "");
    }
  }

  static Future<ChatUser> getChatUserByID(int _id) async {
    try {
      var db = ChatHelper();
      await db.open();
      ChatUser chatUser = await db.selectByID(_id);
      await db.close();
      return chatUser;
    } catch (e) {
      print("Error : ${e.toString()}");
      return ChatUser(id: -1, name: "", username: "");
    }
  }

  static Future<List<ChatUser>> getAllUsers() async {
    try {
      var db = ChatHelper();
      await db.open();
      List<ChatUser> chatUsers = await db.selectAll();
      await db.close();
      return chatUsers;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteUsername(String _username) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.deleteByUsername(_username);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteUserID(String _id) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.deleteByUserID(_id);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteAll() async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.deleteAll();
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }
}
