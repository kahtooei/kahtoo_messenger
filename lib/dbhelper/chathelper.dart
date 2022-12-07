import 'dart:io';

import 'package:kahtoo_messenger/dbhelper/db_helper.dart';
import 'package:kahtoo_messenger/dbmodels/chat.dart';
import 'package:sqflite/sqflite.dart';

class ChatHelper extends dbHelper {
  String _tableName = "chats";

  Future<Chat> insert(Chat chat) async {
    print("insert in chats");
    print(chat.toMap());
    int id = await db.insert(_tableName, chat.toMap());
    print("chat id : $id");
    return chat;
  }

  Future<Chat> select(String _username) async {
    Chat chat = Chat(id: -1, username: "", name: "", type: 0);
    bool has = await hasChat(_username);
    print("has basket is : $has");
    if (has) {
      List<Map> res = await db
          .rawQuery("select * from $_tableName where username = '$_username'");
      print("Select Basket From db is : $res");
      chat = Chat(
        id: res[0]["id"],
        username: res[0]["username"],
        name: res[0]["name"],
        type: res[0]["type"],
      );
    }
    return chat;
  }

  Future<bool> hasChat(String _username) async {
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

  Future<List<Chat>> selectAll() async {
    List<Chat> chats = [];
    List<Map> res = await db.rawQuery("select * from $_tableName where 1=1");
    for (int i = 0; i < res.length; i++) {
      Chat chat = Chat(
        id: res[i]["id"],
        username: res[i]["username"],
        name: res[i]["name"],
        type: res[i]["type"],
      );
      chats.add(chat);
    }
    return chats;
  }

  Future<Chat> updateName(Chat chat) async {
    print("insert in BasketHelper");
    print(chat.toMap());

    await db.rawQuery(
        "update $_tableName set name = '${chat.name}' where username = '${chat.username}'");
    return chat;
  }

  // select count(pid), sum(finalprice), suppliername, supplierlogo from
  Future<bool> insertAll(List<Chat> chats) async {
    print("insertAll in Chats");
    try {
      await Future.wait(chats.map((cht) async {
        await insert(cht);
      }));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String _username) async {
    try {
      var x = await db
          .rawQuery("delete from $_tableName where username = '$_username'");
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
