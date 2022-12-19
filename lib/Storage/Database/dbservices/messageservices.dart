import 'package:kahtoo_messenger/Models/chat_message_model.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import 'package:kahtoo_messenger/Storage/Database/dbhelper/messagehelper.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/message.dart';

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

  static Future<Message> setOne(Message message) async {
    Message msg = Message(
        id: -1,
        author: -1,
        content: "",
        receive_date: "",
        seen_date: "",
        send_date: "");
    try {
      var db = MessageHelper();
      await db.open();
      bool hasMessage = await db.hasMessage(message.id!);
      if (hasMessage) {
        // await db.updateStatus(message);
      } else {
        msg = await db.insert(message);
      }

      await db.close();
      return msg;
    } catch (e) {
      return msg;
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
          author: -1,
          content: "",
          receive_date: "",
          seen_date: "",
          send_date: "");
    }
  }

  static Future<Message> getLastUserMessage(int userID) async {
    try {
      var db = MessageHelper();
      await db.open();
      Message message = await db.lastUserMessage(userID);
      await db.close();
      return message;
    } catch (e) {
      print("Error : ${e.toString()}");
      return Message(
          id: -1,
          author: -1,
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

  static Future<List<ChatMessageModel>> getUserChatMessage(int userID) async {
    try {
      MyModel info = await LocalCache.getMyInfo();
      List<ChatMessageModel> chatMessages = [];
      var db = MessageHelper();
      await db.open();
      List<Message> messages = await db.selectUserMessages(userID);
      for (Message m in messages) {
        DateTime datetime = DateTime.parse(m.send_date!).toLocal();
        DateTime date = DateTime(datetime.year, datetime.month, datetime.day);
        chatMessages.add(ChatMessageModel(
            id: m.id,
            content: m.content,
            isMe: m.author == info.id,
            date: date,
            time:
                "${datetime.hour.toString().padLeft(2, "0")}:${datetime.minute.toString().padLeft(2, "0")}"));
      }
      await db.close();
      return chatMessages;
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
