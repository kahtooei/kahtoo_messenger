import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kahtoo_messenger/API/Http/login_service.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_button.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_textbutton.dart';
import 'package:kahtoo_messenger/Components/Error/show_error_snack.dart';
import 'package:kahtoo_messenger/Components/TextFields/main_textfield.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
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
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, bottom: 5, top: 30),
              child: MainTextField(
                hint: "Username ...",
                controller: usernameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, left: 15, bottom: 30),
              child: MainTextField(
                hint: "Password ...",
                isPassword: true,
                controller: passwordController,
              ),
            ),
            isLoading
                ? CircularProgressIndicator(
                    color: ColorsRepo.getMainColor(),
                  )
                : SizedBox(
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

  loginClick() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ShowErrorSnack.show("Empty Username Or Password",
          "Enter Username And Password For Login");
    } else {
      setState(() {
        isLoading = true;
      });
      var result = await LoginService.login(MyModel(
          username: usernameController.text,
          token: '',
          password: passwordController.text));
      setState(() {
        isLoading = false;
      });
      if (result) {
        await LocalCache.setMyInfo(result);
        Get.offAllNamed(ScreenName.home);
      }
    }
  }
}
