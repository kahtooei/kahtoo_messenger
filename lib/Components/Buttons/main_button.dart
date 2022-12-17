import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Constants/Colors.dart';
import 'package:kahtoo_messenger/Constants/Styles.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClicked;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  const MainButton(
      {super.key,
      required this.text,
      this.onClicked,
      this.backgroundColor,
      this.foregroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    print("BackgroundColor ==> $backgroundColor");
    return ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? ColorsRepo.getSecondColor(),
            foregroundColor: foregroundColor ?? ColorsRepo.getMainColor(),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            elevation: 2,
            padding: const EdgeInsets.all(0)),
        child: Text(
          text,
          style: StylesRepo.getStyle(style_name: "buttonText")
              .copyWith(color: textColor ?? Colors.white),
        ));
  }
}
