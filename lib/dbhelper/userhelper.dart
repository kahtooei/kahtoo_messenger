import 'dart:io';

import 'package:kahtoo_messenger/dbhelper/db_helper.dart';
import 'package:kahtoo_messenger/dbmodels/chatuser.dart';
import 'package:sqflite/sqflite.dart';

class ChatHelper extends dbHelper {
  String _tableName = "chatuser";

  Future<ChatUser> insert(ChatUser chatUser) async {
    print("insert in user");
    print(chatUser.toMap());
    int id = await db.insert(_tableName, chatUser.toMap());
    chatUser.id = id;
    print("user id : $id");
    return chatUser;
  }

  Future<ChatUser> selectByUsername(String _username) async {
    ChatUser chatUser = ChatUser(id: -1, username: "", name: "");
    bool has = await hasChatUsername(_username);
    print("has basket is : $has");
    if (has) {
      List<Map> res = await db
          .rawQuery("select * from $_tableName where username = '$_username'");
      chatUser = ChatUser(
          id: res[0]["id"], username: res[0]["username"], name: res[0]["name"]);
    }
    return chatUser;
  }

  Future<bool> hasChatUsername(String _username) async {
    try {
      var x = await db.rawQuery(
          "select count(*) from $_tableName where username = '$_username'");
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

  Future<ChatUser> selectByID(int _id) async {
    ChatUser chatUser = ChatUser(id: -1, username: "", name: "");
    bool has = await hasChatUserID(_id);
    print("has basket is : $has");
    if (has) {
      List<Map> res =
          await db.rawQuery("select * from $_tableName where id = $_id");
      chatUser = ChatUser(
          id: res[0]["id"], username: res[0]["username"], name: res[0]["name"]);
    }
    return chatUser;
  }

  Future<bool> hasChatUserID(int _id) async {
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

  Future<List<ChatUser>> selectAll() async {
    List<ChatUser> chatUsers = [];
    List<Map> res = await db.rawQuery("select * from $_tableName where 1=1");
    for (int i = 0; i < res.length; i++) {
      ChatUser chatUser = ChatUser(
          id: res[i]["id"], username: res[i]["username"], name: res[i]["name"]);
      chatUsers.add(chatUser);
    }
    return chatUsers;
  }

  Future<ChatUser> updateName(ChatUser chatUser) async {
    print(chatUser.toMap());

    await db.rawQuery(
        "update $_tableName set name = '${chatUser.name}' where username = '${chatUser.username}'");
    return chatUser;
  }

  Future<bool> insertAll(List<ChatUser> chatUsers) async {
    print("insertAll in Chats");
    try {
      await Future.wait(chatUsers.map((cht) async {
        await insert(cht);
      }));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteByUsername(String _username) async {
    try {
      var x = await db
          .rawQuery("delete from $_tableName where username = '$_username'");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteByUserID(String _id) async {
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
