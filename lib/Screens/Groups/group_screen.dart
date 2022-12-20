import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Screens/GroupChat/groupchat_listview.dart';
import 'package:kahtoo_messenger/Screens/Groups/group_listview.dart';
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

import '../../API/WS/WebSocketConnect.dart';

class GroupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupScreenState();
}

class GroupScreenState extends State<GroupScreen> {
  final box = GetStorage();
  List<ChatModel> groups = [];
  bool isLoading = true;
  StreamController chatStream = WebSocketConnect.msgStreamController;
  late StreamSubscription subscription;

  late final IOWebSocketChannel channel;
  int data = 1;
  String statusMessage = "";

  @override
  void initState() {
    super.initState();
    firstChecking();
  }

  firstChecking() async {
    groups = await GroupServices.getAllGroupsChatModel();
    setState(() {
      isLoading = false;
    });
    //if add new group or message for group => refresh
    subscription = chatStream.stream.listen((event) async {
      groups = await GroupServices.getAllGroupsChatModel();
      setState(() {});
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Visibility(
          visible: isLoading,
          replacement: Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height - 100,
            padding: const EdgeInsets.all(5),
            child: GroupListView(groupchatList: groups),
          )),
          child: CircularProgressIndicator(
            color: ColorsRepo.getMainColor(),
          )),
    ])));
  }
}
