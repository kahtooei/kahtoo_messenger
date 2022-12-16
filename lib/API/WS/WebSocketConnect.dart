import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
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
  static late IOWebSocketChannel _channel;
  static StreamController<Map> msgStreamController =
      StreamController<Map>.broadcast();

  static startConnection() async {
    Map myInfo = await LocalCache.getMyInfo();
    _channel = IOWebSocketChannel.connect(
      Uri.parse(
          '${AddressRepo.getSocketAddress()}${myInfo[LocalCache.tokenKey]}/'),
    );
    _channel.stream.listen(
      (message) {
        // channel.sink.close(status.goingAway);
        isConnected = true;
        Map msg = json.decode(message);
        // handleReceivedMessages(msg['message']);
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

  handleReceivedMessages(Map _data) {
    Map functionsList = {
      'groups': getGroups,
      "fetch_message": fetchMessage,
      "group_data": updateGroup,
      "new_message": newMessage
    };
    functionsList[_data['type_data']](_data);
  }

  getGroups(Map _groupsData) async {
    _channel.sink.add(json.encode({"command": "fetch"}));
  }

  fetchMessage(Map _message) async {
    //get Message Body
    Map message = _message['message'];

    //check group message
    bool isGroupMsg = _message['group'] != null;
    ChatGroup group = ChatGroup(id: -1, groupname: "", name: "");
    if (isGroupMsg) {
      Map groupData = _message['group'];
      group = await getGroupData(
          groupname: groupData['groupname'], name: groupData['name']);
    }

    //check author of message
    ChatUser author = await getUserData(
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
  }

  updateGroup(Map _groupData) {}

  newMessage(Map _message) async {
    //send request to get group data if it's not exist
    ChatUser author = await getUserData(
        username: _message['author']['username'],
        name: _message['author']['name']);

    bool isGroupMsg = _message['status'] == 3;
    ChatGroup group = ChatGroup(id: -1, groupname: "", name: "");
    if (isGroupMsg) {
      group = await getGroupData(groupname: _message['groupname']);
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
  }

  Future<ChatUser> getUserData(
      {required String username, required String name}) async {
    ChatUser user = await UserServices.getChatUserByUsername(username);
    if (user.id! < 1) {
      user =
          await UserServices.setOne(ChatUser(username: username, name: name));
    }
    return user;
  }

  Future<ChatGroup> getGroupData(
      {required String groupname, String name = ""}) async {
    ChatGroup grp = await GroupServices.getChatGroupByGroupname(groupname);
    if (grp.id! < 1) {
      grp = ChatGroup(groupname: groupname, name: name);
      grp = await GroupServices.setOne(grp);
    }
    return grp;
  }
}
