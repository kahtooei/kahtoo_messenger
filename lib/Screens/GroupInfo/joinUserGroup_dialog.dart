import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahtoo_messenger/Components/Buttons/main_button.dart';
import 'package:kahtoo_messenger/Components/TextFields/main_textfield.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';

import 'join_get.dart';

class JoinUserGroupDialog extends StatelessWidget {
  final String groupname;
  JoinUserGroupDialog({super.key, required this.groupname});

  final TextEditingController controller = TextEditingController();
  final joinGet = NewJoinGet();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Join User To Group"),
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
              () => joinGet.isLoading.value
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
                          onClicked: () =>
                              joinGet.join(controller.text, groupname),
                          backgroundColor: Colors.black,
                          text: "Join"),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
