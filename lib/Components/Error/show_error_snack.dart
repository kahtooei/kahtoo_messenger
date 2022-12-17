import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowErrorSnack {
  ShowErrorSnack._();
  static show(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.grey.shade200,
        colorText: Colors.black,
        duration: const Duration(seconds: 4));
  }
}
