import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/pages/login_page.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially, show login page
  bool _showLoginPage = true;
  // toggle between login and register page
  void togglePages() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
