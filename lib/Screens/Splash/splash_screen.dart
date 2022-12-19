import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kahtoo_messenger/API/WS/WebSocketConnect.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';
import 'package:kahtoo_messenger/Storage/Database/dbservices/userservices.dart';

import '../../Storage/Database/dbmodels/chatuser.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ColorsRepo.getMainColor(),
      child: Center(
        child: CircularProgressIndicator(
            color: ColorsRepo.getColors(colorName: "progress")),
      ),
    );
  }

  checkStatus() async {
    MyModel myInfo = await LocalCache.getMyInfo();
    if (myInfo.isValidate()) {
      await checkMyInfoInDB(myInfo);
      WebSocketConnect.startConnection();
      Get.offAndToNamed(ScreenName.home);
    } else {
      Get.offAndToNamed(ScreenName.welcome);
      debugPrint("it's not login");
    }
  }

  checkMyInfoInDB(MyModel info) async {
    ChatUser user = await UserServices.getChatUserByUsername(info.username!);
    if (user.id! <= 0) {
      user.name = info.fullName;
      user.username = info.username;
      user = await UserServices.setOne(user);
    }
    LocalCache.setMyInfoID(user.id!);
  }
}
