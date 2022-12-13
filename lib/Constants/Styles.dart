import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Constants/Fonts.dart';

class StylesRepo {
  TextStyle getStyle({required String style_name}) {
    Map<String, TextStyle> styles = {
      'H1': TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: FontsRepo.getFontName())
    };
    return styles[style_name] ?? TextStyle();
  }
}
