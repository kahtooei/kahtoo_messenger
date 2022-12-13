import 'package:flutter/material.dart';

class ColorsRepo {
  static Color getMainColor() {
    return Color(0xff7165ff);
  }

  static Color getSecondColor() {
    return Color(0x996a2dff);
  }

  static Color getColors({required String colorName}) {
    Map<String, Color> myColors = {
      "main": getMainColor(),
      "second": getSecondColor(),
      "icon": Colors.black54,
      "title": Colors.black,
      "textMenu": Colors.black,
      "mainPrice": Colors.black,
      "producttitle": Colors.black,
      "oldprice": Colors.grey,
      "badge": Colors.white,
      "bottomicon": Colors.white,
      "bodybackground": Colors.white,
      "appbarbackground": Colors.white,
      "bottombackground": Colors.white,
      "categorybackground": Colors.white,
      "productbackground": Colors.white,
      "buttontext": Colors.white,
      "shadow": Colors.grey,
      "border": Color(0xffe0e0e0),
      "checkmark": getMainColor(),
      "link": Colors.blue,
      "productdesc": Colors.grey,
      "sebmain": Color(0xfffdfdfd),
      "mygrey": Color(0xffececec),
      "mygrey1": Color(0xfff8f8f8),
      "addtobasket": Colors.green,
      "cancelbuy": Colors.red,
      "mainbck": Color(0xffa0f1dd),
      "secondbck": Color(0xfffd8271),
      "mainbck1": Color(0xffbbe8dd),
      "secondbck1": Color(0xfffda89b),
      "status-bck-ok": Color(0xff41c2a3),
      "status-txt-ok": Color(0xffffffff),
      "status-bck-temp": Color(0xfffa8c31),
      "status-txt-temp": Color(0xffffffff),
      "status-bck-failed": Color(0xffff523b),
      "status-txt-failed": Color(0xfffdfdfd),
      "status-bck-none": Color(0xff636262),
      "status-txt-none": Color(0xffffffff),
      "status-bck-prepare": Color(0xff0352fa),
      "status-txt-prepare": Color(0xfffafafa),
      "status-bck-sent": Color(0xff41c2a3),
      "status-txt-sent": Color(0xfffafafa),
      "status-bck-other": Color(0xff7ba6ff),
      "status-txt-other": Color(0xff014ff5),
      "status-txt-prepare": Color(0xffcecece),
    };
    return myColors[colorName] ?? getMainColor();
  }
}
