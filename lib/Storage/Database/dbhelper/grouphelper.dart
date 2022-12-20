import 'dart:io';

import 'package:kahtoo_messenger/Storage/Database/dbhelper/db_helper.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatgroup.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Models/chat_model.dart';
import '../../../Models/my_model.dart';
import '../../Cache/local_cache.dart';
import '../dbmodels/message.dart';
import '../dbservices/messageservices.dart';

class ChatHelper extends dbHelper {
  String _tableName = "chatgroup";

  Future<ChatGroup> insert(ChatGroup chatGroup) async {
    print("insert in group");
    print(chatGroup.toMap());
    int id = await db.insert(_tableName, chatGroup.toMap());
    chatGroup.id = id;
    print("group id : $id");
    return chatGroup;
  }

  Future<ChatGroup> selectByGroupname(String _groupname) async {
    ChatGroup chatGroup = ChatGroup(id: -1, groupname: "", name: "");
    bool has = await hasChatGroupname(_groupname);
    print("has basket is : $has");
    if (has) {
      List<Map> res = await db.rawQuery(
          "select * from $_tableName where groupname = '$_groupname'");
      chatGroup = ChatGroup(
          id: res[0]["id"],
          groupname: res[0]["groupname"],
          name: res[0]["name"]);
    }
    return chatGroup;
  }

  Future<bool> hasChatGroupname(String _groupname) async {
    try {
      var x = await db.rawQuery(
          "select count(*) from $_tableName where groupname = '$_groupname'");
      int count = Sqflite.firstIntValue(x)!;
      if (count > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<ChatGroup> selectByID(int _id) async {
    ChatGroup chatGroup = ChatGroup(id: -1, groupname: "", name: "");
    bool has = await hasChatGroupID(_id);
    if (has) {
      List<Map> res =
          await db.rawQuery("select * from $_tableName where id = $_id");
      chatGroup = ChatGroup(
          id: res[0]["id"],
          groupname: res[0]["groupname"],
          name: res[0]["name"]);
    }
    return chatGroup;
  }

  Future<bool> hasChatGroupID(int _id) async {
    try {
      var x =
          await db.rawQuery("select count(*) from $_tableName where id = $_id");
      int count = Sqflite.firstIntValue(x)!;
      if (count > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<ChatGroup>> selectAll() async {
    List<ChatGroup> chatGroups = [];
    List<Map> res = await db.rawQuery("select * from $_tableName where 1=1");
    for (int i = 0; i < res.length; i++) {
      ChatGroup chatGroup = ChatGroup(
          id: res[i]["id"],
          groupname: res[i]["groupname"],
          name: res[i]["name"]);
      chatGroups.add(chatGroup);
    }
    return chatGroups;
  }

  Future<List<ChatModel>> selectGroupsChatModel() async {
    List<ChatModel> chatList = [];
    MyModel info = await LocalCache.getMyInfo();
    List<ChatGroup> groups = await selectAll();
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    for (ChatGroup group in groups) {
      Message message = await MessageServices.getLastGroupMessage(group.id!);
      int unReadMessageCount =
          await MessageServices.getGroupUnreadMessageCount(group.id!);
      if (message.id! > 0) {
        DateTime parsedDate = DateTime.parse(message.send_date!).toLocal();
        String MessageDate = "";
        if (today.compareTo(parsedDate) < 0) {
          MessageDate = "${parsedDate.hour}:${parsedDate.minute}";
        } else {
          MessageDate =
              "${parsedDate.year}/${parsedDate.month}/${parsedDate.day}";
        }
        chatList.add(ChatModel(
            id: group.id,
            name: group.name,
            username: group.groupname,
            unReadCount: unReadMessageCount,
            lastMessage: message.content,
            lastMessageDate: MessageDate,
            avatarURL: "https://cdn-icons-png.flaticon.com/512/25/25437.png"));
      } else {
        chatList.add(ChatModel(
            id: group.id,
            name: group.name,
            username: group.groupname,
            unReadCount: unReadMessageCount,
            lastMessage: "",
            lastMessageDate: "",
            avatarURL: "https://cdn-icons-png.flaticon.com/512/25/25437.png"));
      }
    }
    return chatList;
  }

  Future<ChatGroup> updateName(ChatGroup chatGroup) async {
    print(chatGroup.toMap());

    await db.rawQuery(
        "update $_tableName set name = '${chatGroup.name}' where groupname = '${chatGroup.groupname}'");
    return chatGroup;
  }

  Future<bool> insertAll(List<ChatGroup> chatGroups) async {
    print("insertAll in Chats");
    try {
      await Future.wait(chatGroups.map((cht) async {
        await insert(cht);
      }));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteByGroupname(String _groupname) async {
    try {
      var x = await db
          .rawQuery("delete from $_tableName where groupname = '$_groupname'");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteByGroupID(String _id) async {
    try {
      var x = await db.rawQuery("delete from $_tableName where id = $_id");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      var x = await db.rawQuery("delete from $_tableName where 1=1");
      return true;
    } catch (e) {
      return false;
    }
  }
}
