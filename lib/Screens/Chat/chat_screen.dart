import 'dart:async';

import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/API/WS/WebSocketConnect.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Models/chat_message_model.dart';
import 'package:kahtoo_messenger/Models/chat_model.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Screens/Chat/chats_listview.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/messageservices.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Storage/Database/dbmodels/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  StreamController chatStream = WebSocketConnect.msgStreamController;
  late StreamSubscription subscription;
  bool isLoading = true;
  late ChatModel chat;
  List<ChatMessageModel> chats = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var arg = Get.arguments;
    chat = arg['chat'];
    loadChats();
  }

  loadChats() async {
    MyModel info = await LocalCache.getMyInfo();
    chats = await MessageServices.getUserChatMessage(chat.id!);

    setState(() {
      isLoading = false;
    });

    subscription = chatStream.stream.listen((event) {
      if (event['type'] == "message" &&
          ((event['author'] == chat.username &&
                  event['receiver'] == info.username) ||
              (event['author'] == info.username &&
                  event['receiver'] == chat.username)) &&
          event['isGroup'] == false) {
        chats.add(ChatMessageModel(
            id: event['id'],
            content: event['content'],
            date: event['date'],
            isMe: event['isMe'],
            time: event['time']));
        setState(() {});
        refreshScroll();
        if (event['author'] == chat.username) {
          WebSocketConnect.seenMessage(event['id']);
        }
      }
    });
    refreshScroll();
  }

  refreshScroll() async {
    await Future.delayed(const Duration(milliseconds: 100));
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Get.toNamed(ScreenName.userInfo, arguments: {'chat': chat});
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(chat.avatarURL ?? ''),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(chat.name!)
            ],
          ),
        ),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: Center(
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ChatsListView(
                        chats: chats, controller: scrollController),
                  ),
                ),
                MessageBar(
                  onSend: (text) {
                    WebSocketConnect.sendMessage(text, chat.username!, false);
                  },
                ),
              ],
            ),
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorsRepo.getMainColor(),
          ),
        ),
      ),
    );
  }
}
