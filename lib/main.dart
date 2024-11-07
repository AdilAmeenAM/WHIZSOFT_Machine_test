import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/core/theme/light_theme.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/pages/login_or_register_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      home: const LoginOrRegisterPage(),
    );
  }
}
