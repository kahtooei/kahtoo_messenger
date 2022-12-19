import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
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

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final box = GetStorage();
  List<ChatModel> users = [];
  bool isLoading = true;
  StreamController chatStream = WebSocketConnect.msgStreamController;

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
    users = await UserServices.getAllUsersChatModel();
    setState(() {
      isLoading = false;
    });
    chatStream.stream.listen((event) async {
      users = await UserServices.getAllUsersChatModel();
      setState(() {});
    });
  }

  @override
  void dispose() {
    chatStream.close();
    super.dispose();
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
              padding: const EdgeInsets.all(5),
              child: MessageListView(chatList: users),
            )),
    ])));
  }
}
