import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kahtoo_messenger/API/Http/register_service.dart';
import 'package:kahtoo_messenger/Constants/Addresses.dart';
import 'package:kahtoo_messenger/Models/my_model.dart';
import 'package:kahtoo_messenger/Storage/Cache/local_cache.dart';

import '../../Components/Buttons/main_button.dart';
import '../../Components/Buttons/main_textbutton.dart';
import '../../Components/Error/show_error_snack.dart';
import '../../Components/TextFields/main_textfield.dart';
import '../../Constants/Colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
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
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, bottom: 5, top: 30),
              child: MainTextField(
                hint: "FullName ...",
                controller: fullNameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: 5,
              ),
              child: MainTextField(
                hint: "Username ...",
                controller: usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 30),
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
                      text: "Register",
                      onClicked: registerClick,
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

  registerClick() async {
    if (fullNameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      var result = await RegisterService.register(MyModel(
          fullName: fullNameController.text,
          username: usernameController.text,
          password: passwordController.text,
          token: '-1'));
      if (result) {
        await LocalCache.setMyInfo(result);
        Get.offAllNamed(ScreenName.home);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ShowErrorSnack.show(
          "Empty Fields", "Enter FullName-Username-Password For Register");
    }
  }

  goToLogin() {
    Get.offNamed(ScreenName.login);
  }
}
