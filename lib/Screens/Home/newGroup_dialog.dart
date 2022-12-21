import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_button.dart';
import 'package:kahtoo_messenger/Components/TextFields/main_textfield.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Screens/Home/newGroup_get.dart';

class NewGroupDialog extends StatelessWidget {
  NewGroupDialog({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  final groupGet = NewGroupGet();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Group"),
      content: Container(
        height: 200,
        child: Column(
          children: [
            MainTextField(
              controller: nameController,
              hint: "Enter Name...",
            ),
            SizedBox(
              height: 5,
            ),
            MainTextField(
              controller: groupController,
              hint: "Enter groupname...",
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(
              () => groupGet.isLoading.value
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
                          onClicked: () => groupGet.createGroup(
                              groupController.text, nameController.text),
                          backgroundColor: Colors.black,
                          text: "Create Group"),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
