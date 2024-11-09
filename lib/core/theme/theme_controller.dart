import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whizsoft_chat_app_machine_test/core/theme/dark_theme.dart';
import 'package:whizsoft_chat_app_machine_test/core/theme/light_theme.dart';

part 'theme_controller.g.dart';

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeData build() {
    return lightTheme;
  }

//  toggle the theme between light and dark
  void toggleTheme() {
    if (state.brightness == Brightness.light) {
      state = darkTheme;
    } else {
      state = lightTheme;
    }
  }
}
