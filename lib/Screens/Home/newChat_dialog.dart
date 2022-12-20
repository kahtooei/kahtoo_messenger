import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_button.dart';
import 'package:kahtoo_messenger/Components/TextFields/main_textfield.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Screens/Home/newChat_get.dart';

class NewChatDialog extends StatelessWidget {
  NewChatDialog({super.key});

  TextEditingController controller = TextEditingController();
  final chatGet = NewChatGet();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Chat"),
      content: Container(
        height: 150,
        child: Column(
          children: [
            MainTextField(
              controller: controller,
              hint: "Enter Username...",
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(
              () => chatGet.isLoading.value
                  ? SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: ColorsRepo.getMainColor(),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: MainButton(
                          onClicked: () => chatGet.startChat(controller.text),
                          backgroundColor: Colors.black,
                          text: "Start Chat"),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
