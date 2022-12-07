import 'package:kahtoo_messenger/dbmodels/chat.dart';
import 'package:kahtoo_messenger/dbhelper/chathelper.dart';

class ChatServices {
  static Future<bool> setAll(List<Chat> chats) async {
    try {
      var db = ChatHelper();
      await db.open();
      await db.insertAll(chats);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setOne(Chat chat) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool hasChat = await db.hasChat(chat.username!);
      if (hasChat) {
        // await db.updateName(chat);
      } else {
        await db.insert(chat);
      }

      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateName(Chat chat) async {
    try {
      var db = ChatHelper();
      await db.open();
      await db.updateName(chat);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasItem(String _username) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.hasChat(_username);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<Chat> getChat(String _username) async {
    try {
      var db = ChatHelper();
      await db.open();
      Chat chat = await db.select(_username);
      await db.close();
      return chat;
    } catch (e) {
      print("Error : ${e.toString()}");
      return Chat(id: -1, name: "", username: "", type: -1);
    }
  }

  static Future<List<Chat>> getAllChat() async {
    try {
      var db = ChatHelper();
      await db.open();
      List<Chat> chats = await db.selectAll();
      await db.close();
      return chats;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteItem(String _username) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.delete(_username);
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
