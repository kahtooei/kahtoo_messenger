import 'package:flutter/material.dart';
import 'package:kahtoo_messenger/Constants/Fonts.dart';

class StylesRepo {
  StylesRepo._();
  static TextStyle getStyle({required String style_name}) {
    Map<String, TextStyle> styles = {
      'H1': TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: FontsRepo.getFontName()),
      'H3': TextStyle(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: FontsRepo.getFontName()),
      'buttonText': TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: FontsRepo.getFontName()),
      'textButton': TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: FontsRepo.getFontName()),
      'mainTextField': TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: FontsRepo.getFontName()),
      'hintMainTextField': TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: FontsRepo.getFontName()),
    };
    return styles[style_name] ?? const TextStyle();
  }
}
