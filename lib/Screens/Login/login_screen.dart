import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_button.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_textbutton.dart';
import 'package:kahtoo_messenger/Components/TextFields/main_textfield.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                "Login",
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
                text: "Login",
                onClicked: loginClick,
              ),
            ),
            const MainTextButton(
              text: "Forget Password?",
              textColor: Colors.black54,
            )
          ],
        ),
      ),
    );
  }

  loginClick() {}
}
