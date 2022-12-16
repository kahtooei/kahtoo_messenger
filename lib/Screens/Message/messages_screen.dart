import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatgroup.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/chatuser.dart';
import 'package:kahtoo_messenger/Storage/Database/dbmodels/message.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/groupservice.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/userservices.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/messageservices.dart';
import 'package:kahtoo_messenger/Screens/Message/messageListView.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final box = GetStorage();
  List<ChatUser> users = [];
  bool isLoading = true;

  late final IOWebSocketChannel channel;
  int data = 1;
  String statusMessage = "";
  int counter = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstChecking();
  }

  firstChecking() async {
    users = await UserServices.getAllUsers();
    setState(() {
      isLoading = false;
    });
    //just for development time
    late String token, username;

    token = "mohammad";
    // channel = IOWebSocketChannel.connect(
    //   Uri.parse('ws://likerdshop.ir:7444/ws/messenger/$token/'),
    // );
    // channel.stream.listen(
    //   (message) {
    //     // channel.sink.close(status.goingAway);
    //     Map msg = json.decode(message);
    //     handleReceivedMessages(msg['message']);
    //   },
    //   onDone: () {
    //     print("Disconnected");
    //   },
    //   onError: (error) {
    //     print("Run OnError Method With Value : $error");
    //   },
    // );
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      isLoading
          ? CircularProgressIndicator(
              color: ColorsRepo.getMainColor(),
            )
          : Expanded(
              child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height - 100,
              child: MessageListView(userList: users),
            )),
    ])));
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
    // List groups = _groupsData['groups'];
    // for (Map grp in groups) {
    //   ChatGroup group =
    //       ChatGroup(name: grp['name'], groupname: grp['groupname']);
    //   await GroupServices.setOne(group);
    // }
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
    channel.sink.add(json.encode({
      "command": "receive",
      "values": {"messageID": _message['message']['id']}
    }));
  }

  updateGroup(Map _groupData) {}

  NewMessage(Map _message) async {
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
    channel.sink.add(json.encode({
      "command": "receive",
      "values": {"messageID": _message['id']}
    }));
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

  Future<ChatUser> getUserData(
      {required String username, required String name}) async {
    ChatUser user = await UserServices.getChatUserByUsername(username);
    if (user.id! < 1) {
      user =
          await UserServices.setOne(ChatUser(username: username, name: name));
    }
    return user;
  }

  List<Widget> getTestWidget() {
    return [
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
    ];
  }
}
