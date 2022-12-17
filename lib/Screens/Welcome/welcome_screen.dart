import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_textbutton.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';

import '../../Components/Buttons/main_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorsRepo.getColors(colorName: "mygrey"),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.chat,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Kahtoo Messenger",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: double.infinity,
                    height: 40,
                    margin:
                        const EdgeInsets.only(bottom: 80, right: 25, left: 25),
                    child: MainButton(
                      text: "Login",
                      onClicked: goToLogin,
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New to KahtooChat? ",
                        style: StylesRepo.getStyle(style_name: "H3")
                            .copyWith(color: Colors.black54),
                      ),
                      MainTextButton(
                        text: "Sign Up",
                        onClicked: goToRegister,
                        textColor: ColorsRepo.getMainColor(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  goToLogin() {
    Get.toNamed(ScreenName.login);
  }

  goToRegister() {
    Get.toNamed(ScreenName.register);
  }
}
