import 'dart:io';
import 'package:kahtoo_messenger/dbhelper/db_helper.dart';
import 'package:kahtoo_messenger/dbmodels/message.dart';
import 'package:sqflite/sqflite.dart';

class MessageHelper extends dbHelper {
  String _tableName = "messages";

  Future<Message> insert(Message message) async {
    print("insert in messages");
    print(message.toMap());
    int id = await db.insert(_tableName, message.toMap());
    print("message id : $id");
    return message;
  }

  Future<Message> select(int _id) async {
    Message message = Message(
      id: -1,
      author: "",
      content: "",
      chat: "",
      send_date: "",
      receive_date: null,
      seen_date: null,
    );
    bool has = await hasMessage(_id);
    print("has basket is : $has");
    if (has) {
      List<Map> res =
          await db.rawQuery("select * from $_tableName where id = $_id");
      print("Select Basket From db is : $res");
      message = Message(
        id: res[0]["id"],
        author: res[0]["author"],
        content: res[0]["content"],
        chat: res[0]["chat"],
        send_date: res[0]["send_date"],
        receive_date: res[0]["receive_date"],
        seen_date: res[0]["seen_date"],
      );
    }
    return message;
  }

  Future<bool> hasMessage(int _id) async {
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

  Future<List<Message>> selectAll() async {
    List<Message> messages = [];
    List<Map> res = await db.rawQuery("select * from $_tableName where 1=1");
    for (int i = 0; i < res.length; i++) {
      Message message = Message(
        id: res[i]["id"],
        author: res[i]["author"],
        content: res[i]["content"],
        chat: res[i]["chat"],
        send_date: res[0]["send_date"],
        receive_date: res[0]["receive_date"],
        seen_date: res[0]["seen_date"],
      );
      messages.add(message);
    }
    return messages;
  }

  Future<Message> updateStatus(Message message) async {
    await db.rawQuery(
        "update $_tableName set receive_date = '${message.receive_date}' , seen_date = '${message.seen_date}' where id = ${message.id}");
    return message;
  }

  // select count(pid), sum(finalprice), suppliername, supplierlogo from
  Future<bool> insertAll(List<Message> messages) async {
    try {
      await Future.wait(messages.map((msg) async {
        await insert(msg);
      }));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int _id) async {
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
