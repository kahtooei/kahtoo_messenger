import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatgroup.dart';
import 'package:kahtoo_messenger/Storage/Database/dbhelper/grouphelper.dart';

import '../../../Models/chat_model.dart';

class GroupServices {
  static Future<bool> setAll(List<ChatGroup> chatGroups) async {
    try {
      var db = ChatHelper();
      await db.open();
      await db.insertAll(chatGroups);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<ChatGroup> setOne(ChatGroup chatGroup) async {
    ChatGroup createdGroup = ChatGroup(id: -1, groupname: "", name: "");
    try {
      var db = ChatHelper();
      await db.open();
      bool hasChat = await db.hasChatGroupname(chatGroup.groupname!);
      if (hasChat) {
        createdGroup = await getChatGroupByGroupname(chatGroup.groupname!);
      } else {
        createdGroup = await db.insert(chatGroup);
      }
      await db.close();
      return createdGroup;
    } catch (e) {
      return createdGroup;
    }
  }

  static Future<bool> updateName(ChatGroup chatGroup) async {
    try {
      var db = ChatHelper();
      await db.open();
      await db.updateName(chatGroup);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasGroupname(String _groupname) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.hasChatGroupname(_groupname);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasGroupID(int _id) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.hasChatGroupID(_id);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<ChatGroup> getChatGroupByGroupname(String _groupname) async {
    try {
      var db = ChatHelper();
      await db.open();
      ChatGroup chatUser = await db.selectByGroupname(_groupname);
      await db.close();
      return chatUser;
    } catch (e) {
      print("Error : ${e.toString()}");
      return ChatGroup(id: -1, name: "", groupname: "");
    }
  }

  static Future<ChatGroup> getChatGroupByID(int _id) async {
    try {
      var db = ChatHelper();
      await db.open();
      ChatGroup chatGroup = await db.selectByID(_id);
      await db.close();
      return chatGroup;
    } catch (e) {
      print("Error : ${e.toString()}");
      return ChatGroup(id: -1, name: "", groupname: "");
    }
  }

  static Future<List<ChatModel>> getAllGroupsChatModel() async {
    try {
      var db = ChatHelper();
      await db.open();
      List<ChatModel> chatGroups = await db.selectGroupsChatModel();
      await db.close();
      return chatGroups;
    } catch (e) {
      return [];
    }
  }

  static Future<List<ChatGroup>> getAllGroups() async {
    try {
      var db = ChatHelper();
      await db.open();
      List<ChatGroup> chatGroups = await db.selectAll();
      await db.close();
      return chatGroups;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteGroupname(String _groupname) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.deleteByGroupname(_groupname);
      await db.close();
      return res;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteGroupID(String _id) async {
    try {
      var db = ChatHelper();
      await db.open();
      bool res = await db.deleteByGroupID(_id);
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
