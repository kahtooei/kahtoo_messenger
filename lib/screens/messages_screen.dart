import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/dbmodels/chatgroup.dart';
import 'package:kahtoo_messenger/dbmodels/chatuser.dart';
import 'package:kahtoo_messenger/dbmodels/message.dart';
import 'package:kahtoo_messenger/dbservices/groupservice.dart';
import 'package:kahtoo_messenger/dbservices/userservices.dart';
import 'package:kahtoo_messenger/dbservices/messageservices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  late SharedPreferences sp;
  late final IOWebSocketChannel channel;
  int data = 1;
  String statusMessage = "";
  String myUsername = "m.kahtooei";
  int counter = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("INIT STATE");
    firstChecking();
  }

  firstChecking() async {
    print("FIRST CHECKING");
    sp = await SharedPreferences.getInstance();
    //just for development time
    late String token, username;

    token = "mohammad";
    channel = IOWebSocketChannel.connect(
      Uri.parse('ws://likerdshop.ir:7444/ws/messenger/$token/'),
    );
    channel.stream.listen(
      (message) {
        // channel.sink.close(status.goingAway);
        Map msg = json.decode(message);
        handleReceivedMessages(msg['message']);
      },
      onDone: () {
        print("Disconnected");
      },
      onError: (error) {
        print("Run OnError Method With Value : $error");
      },
    );
  }

  checking() async {
    String a = "";
    print("############ MESSAGE ###############");
    List<Message> messages = await MessageServices.getAllMessage();
    List<Map> msgs = [];
    print("----- Message -----");
    for (Message m in messages) {
      msgs.add(m.toMap());

      print("- ${m.content}\n");
    }
    print("############ GROUP ###############");
    List<ChatGroup> groups = await GroupServices.getAllGroups();
    print("----- Group -----");
    for (ChatGroup c in groups) {
      print("- ${c.groupname}");
    }
    print("############ USER ###############");
    List<ChatUser> users = await UserServices.getAllUsers();
    print("----- User -----");
    for (ChatUser u in users) {
      print("- ${u.username}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$statusMessage : $data"),
        IconButton(
            onPressed: () async {
              checking();
            },
            icon: Icon(Icons.check)),
        IconButton(
            onPressed: () async {
              MessageServices.deleteAll();
              UserServices.deleteAll();
              GroupServices.deleteAll();
            },
            icon: Icon(Icons.delete)),
        Text(statusMessage),
        IconButton(
            onPressed: () async {
              channel.sink.close(status.goingAway);
            },
            icon: Icon(Icons.discord)),
      ],
    )));
  }

  handleReceivedMessages(Map _data) {
    Map functionsList = {
      'groups': getGroups,
      "fetch_message": fetchMessage,
      "group_data": updateGroup,
      "new_message": NewMessage
    };
    functionsList[_data['type_data']](_data);
  }

  getGroups(Map _groupsData) async {
    List groups = _groupsData['groups'];
    for (Map grp in groups) {
      ChatGroup group =
          ChatGroup(name: grp['name'], groupname: grp['groupname']);
      await GroupServices.setOne(group);
    }
    channel.sink.add(json.encode({"command": "fetch"}));
  }

  fetchMessage(Map _message) async {
    //get Message Body
    Map message = _message['message'];

    //check group message
    bool isGroupMsg = _message['group'] != null;
    ChatGroup group = ChatGroup(id: -1, groupname: "", name: "");
    if (isGroupMsg) {
      Map groupData = _message['group'];
      group =
          await GroupServices.getChatGroupByGroupname(groupData['groupname']);
      if (group.id! < 1) {
        group = ChatGroup(
            groupname: groupData['groupname'], name: groupData['name']);
        group = await GroupServices.setOne(group);
      }
    }

    //check author of message
    ChatUser author =
        await UserServices.getChatUserByUsername(message['author']['username']);
    if (author.id! < 1) {
      author = await UserServices.setOne(ChatUser(
          username: message['author']['username'],
          name: message['author']['name']));
    }

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
      print(
          "*********************** CREATED Message : ${newMsg.toMap()} ***********************");
    } catch (e) {
      print("Error => $e");
    }
    channel.sink.add(json.encode({
      "command": "receive",
      "values": {"messageID": _message['message']['id']}
    }));
  }

  updateGroup(Map _groupData) {}

  NewMessage(Map _message) {
    //send request to get group data if it's not exist
  }
}
