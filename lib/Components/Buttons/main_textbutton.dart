import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';

class MainTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClicked;
  final Color? textColor;
  const MainTextButton(
      {super.key,
      required this.text,
      this.onClicked,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClicked,
        child: Text(
          text,
          style: StylesRepo.getStyle(style_name: "textButton")
              .copyWith(color: textColor),
        ));
  }
}
