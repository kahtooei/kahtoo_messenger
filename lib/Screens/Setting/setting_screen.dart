import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kahtoo_messenger/API/WS/WebSocketConnect.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_button.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Config.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/groupservice.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/messageservices.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/userservices.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Username",
              style: StylesRepo.getStyle(style_name: "tiny"),
            ),
            Text(
              Config.myInfo.username!,
              style: StylesRepo.getStyle(style_name: "title"),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Name", style: StylesRepo.getStyle(style_name: "tiny")),
            Text(Config.myInfo.fullName!,
                style: StylesRepo.getStyle(style_name: "title")),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
              child: SizedBox(
                width: double.infinity,
                height: 35,
                child: MainButton(
                  text: "Log Out",
                  backgroundColor: Colors.red,
                  onClicked: logout,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  logout() async {
    await LocalCache.deleteMyInfo();
    await WebSocketConnect.endConnection();
    await MessageServices.deleteAll();
    await UserServices.deleteAll();
    await GroupServices.deleteAll();
    Get.offAllNamed(ScreenName.splash);
  }
}
