import 'dart:async';
import 'dart:convert';

import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import 'package:web_socket_channel/io.dart';

import '../../Storage/Database/dbmodels/chatgroup.dart';
import '../../Storage/Database/dbmodels/chatuser.dart';
import '../../Storage/Database/dbmodels/message.dart';
import '../../Storage/Database/dbservices/groupservice.dart';
import '../../Storage/Database/dbservices/messageservices.dart';
import '../../Storage/Database/dbservices/userservices.dart';

class WebSocketConnect {
  WebSocketConnect._();

  static bool isConnected = false;
  static int _tryCount = 0;
  static late IOWebSocketChannel _channel;
  static StreamController<Map> msgStreamController =
      StreamController<Map>.broadcast();

  static startConnection() async {
    print("Start Socket Connection To ==>");
    MyModel myInfo = await LocalCache.getMyInfo();
    print("${AddressRepo.getSocketAddress()}${myInfo.token}/");
    _channel = IOWebSocketChannel.connect(
      Uri.parse('${AddressRepo.getSocketAddress()}${myInfo.token}/'),
    );
    _channel.stream.listen(
      (message) {
        Map msg = json.decode(message);
        _handleReceivedMessages(msg['message']);
      },
      onDone: () {
        isConnected = false;
        //try to reconnect
      },
      onError: (error) {
        isConnected = false;
      },
    );
  }

  static _handleReceivedMessages(Map _data) {
    print("Received Data ==> $_data");
    Map functionsList = {
      'groups': _getGroups,
      "fetch_message": _fetchMessage,
      "group_data": _updateGroup,
      "new_message": _newMessage
    };
    functionsList[_data['type_data']](_data);
  }

  static _getGroups(Map _groupsData) async {
    isConnected = true;
    _tryCount = 0;
    _channel.sink.add(json.encode({"command": "fetch"}));
    //save Groups Data If Not Saved
    //msgStreamController.sink.add({'type': 'groupData'});  //BroadCast Group Data
  }

  static _fetchMessage(Map _message) async {
    //get Message Body
    Map message = _message['message'];

    //check group message
    bool isGroupMsg = _message['group'] != null;
    ChatGroup group = ChatGroup(id: -1, groupname: "", name: "");
    if (isGroupMsg) {
      Map groupData = _message['group'];
      group = await _getGroupData(
          groupname: groupData['groupname'], name: groupData['name']);
    }

    //check author of message
    ChatUser author = await _getUserData(
        username: message['author']['username'],
        name: message['author']['name']);

    //insert message
    try {
      Message newMsg = Message(
        id: message['id'],
        content: message['content'],
        author: author.id,
        chatgroup: isGroupMsg ? group.id : null,
        send_date: message['create_date'],
      );
      newMsg = await MessageServices.setOne(newMsg);
    } catch (e) {
      print("Error => $e");
    }
    _channel.sink.add(json.encode({
      "command": "receive",
      "values": {"messageID": _message['message']['id']}
    }));
    //msgStreamController.sink.add({'type': 'fetchMessage'});  //BroadCast Fetched Message Data
  }

  static _updateGroup(Map _groupData) {}

  static _newMessage(Map _message) async {
    print("MY MESSAGE --->");
    print("$_message");
    //send request to get group data if it's not exist
    ChatUser author = await _getUserData(
        username: _message['author']['username'],
        name: _message['author']['name']);

    bool isGroupMsg = _message['status'] == 2;
    ChatGroup group = ChatGroup(id: -1, groupname: "", name: "");
    if (isGroupMsg) {
      group = await _getGroupData(groupname: _message['groupname']);
    }

    try {
      Message newMsg = Message(
        id: _message['id'],
        content: _message['content'],
        author: author.id,
        chatgroup: isGroupMsg ? group.id : null,
        send_date: _message['create_date'],
      );
      newMsg = await MessageServices.setOne(newMsg);
    } catch (e) {
      print("Error => $e");
    }
    _channel.sink.add(json.encode({
      "command": "receive",
      "values": {"messageID": _message['id']}
    }));
    MyModel info = await LocalCache.getMyInfo();
    DateTime datetime = DateTime.parse(_message['create_date']).toLocal();
    msgStreamController.sink.add({
      'type': 'message',
      'author': author.username,
      'isGroup': isGroupMsg,
      'id': _message['id'],
      'content': _message['content'],
      'isMe': info.username == author.username,
      'date': DateTime(datetime.year, datetime.month, datetime.day),
      'time':
          "${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}"
    }); //BroadCast New Message Data
  }

  static Future<ChatUser> _getUserData(
      {required String username, required String name}) async {
    ChatUser user = await UserServices.getChatUserByUsername(username);
    if (user.id! < 1) {
      user =
          await UserServices.setOne(ChatUser(username: username, name: name));
    }
    return user;
  }

  static seenMessage(int messageID) {
    if (isConnected) {
      _channel.sink.add(json.encode({
        "command": "seen",
        "values": {"messageID": messageID}
      }));
      //set seen date in local database
    }
  }

  static sendMessage(String content, String receiver, bool isGroup) {
    if (isConnected && content.isNotEmpty) {
      String temp = isGroup ? "groupname" : "username";
      _channel.sink.add(json.encode({
        "command": "send",
        "message": content,
        "values": {temp: receiver}
      }));
      //set seen date in local database
    }
  }

  static Future<ChatGroup> _getGroupData(
      {required String groupname, String name = ""}) async {
    ChatGroup grp = await GroupServices.getChatGroupByGroupname(groupname);
    if (grp.id! < 1) {
      grp = ChatGroup(groupname: groupname, name: name);
      grp = await GroupServices.setOne(grp);
    }
    return grp;
  }
}
