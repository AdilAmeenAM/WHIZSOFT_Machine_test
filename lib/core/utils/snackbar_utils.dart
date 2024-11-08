import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/main.dart';

class SnackBarUtils {
  static void showSnackbar(String message) {
    App.scaffoldMessengerKey.currentState!
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
