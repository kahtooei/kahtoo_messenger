import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';

import '../../Components/Buttons/main_button.dart';
import '../../Components/Buttons/main_textbutton.dart';
import '../../Components/TextFields/main_textfield.dart';
import '../../Constants/Colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsRepo.getColors(colorName: "mygrey"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.message,
              size: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Register",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              "Kahtoo Messenger",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 30),
              child: MainTextField(
                hint: "FullName ...",
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: 5,
              ),
              child: MainTextField(
                hint: "Username ...",
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15, left: 15, bottom: 30),
              child: MainTextField(hint: "Password ...", isPassword: true),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: 40,
              child: MainButton(
                text: "Register",
                onClicked: loginClick,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have Account? "),
                MainTextButton(
                  onClicked: goToLogin,
                  text: "Login",
                  textColor: Colors.black54,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  loginClick() {}
  goToLogin() {
    Get.offNamed(ScreenName.login);
  }
}
