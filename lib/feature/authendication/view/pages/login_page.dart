import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/widgets/custom_button.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/widgets/custom_textfield_widget.dart';

class LoginPage extends StatelessWidget {
  // email and password text controllers

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // tap to go to register page
  final void Function() onTap;
  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) {
    // auth service
    final authService = AuthService();
    // try login
    try {
      authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo

          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          // welcome back message

          Text(
            "Welcome back ,you have been missed",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),

          const SizedBox(
            height: 25,
          ),
          // email textfield
          CustomTextfieldWidget(
            controller: _emailController,
            hintText: "Email",
            obscureText: false,
          ),
          // password textfield
          const SizedBox(height: 10),
          CustomTextfieldWidget(
            controller: _passwordController,
            hintText: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 25),
          // login button
          CustomButton(
            text: "Login",
            onTap: () => login(context),
          ),

          const SizedBox(
            height: 25,
          ),

          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
