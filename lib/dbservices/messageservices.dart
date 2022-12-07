import 'package:kahtoo_messenger/dbhelper/messagehelper.dart';
import 'package:kahtoo_messenger/dbmodels/message.dart';

class MessageServices {
  static Future<bool> setAll(List<Message> messages) async {
    try {
      var db = MessageHelper();
      await db.open();
      await db.insertAll(messages);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setOne(Message message) async {
    try {
      var db = MessageHelper();
      await db.open();
      bool hasMessage = await db.hasMessage(message.id!);
      if (hasMessage) {
        // await db.updateStatus(message);
      } else {
        await db.insert(message);
      }

      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateStatus(Message message) async {
    try {
      var db = MessageHelper();
      await db.open();
      await db.updateStatus(message);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasItem(int _id) async {
    try {
      var db = MessageHelper();
      await db.open();
      bool res = await db.hasMessage(_id);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<Message> getMessage(int _id) async {
    try {
      var db = MessageHelper();
      await db.open();
      Message message = await db.select(_id);
      await db.close();
      return message;
    } catch (e) {
      print("Error : ${e.toString()}");
      return Message(
          id: -1,
          author: "",
          chat: "",
          content: "",
          receive_date: "",
          seen_date: "",
          send_date: "");
    }
  }

  static Future<List<Message>> getAllMessage() async {
    try {
      var db = MessageHelper();
      await db.open();
      List<Message> messages = await db.selectAll();
      await db.close();
      return messages;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteItem(int _id) async {
    try {
      var db = MessageHelper();
      await db.open();
      bool res = await db.delete(_id);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteAll() async {
    try {
      var db = MessageHelper();
      await db.open();
      bool res = await db.deleteAll();
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }
}
