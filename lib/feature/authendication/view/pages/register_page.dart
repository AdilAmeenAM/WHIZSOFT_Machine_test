import 'package:flutter/material.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/service/auth_service.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/widgets/custom_button.dart';
import 'package:whizsoft_chat_app_machine_test/feature/authendication/view/widgets/custom_textfield_widget.dart';

class RegisterPage extends StatelessWidget {
  // email and password text controllers

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // tap to go to login page
  final void Function() onTap;

  RegisterPage({super.key, required this.onTap});

  //  register method
  void register(BuildContext context) {
    // get auth service
    final auth = AuthService();
    // password match -> create user
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        auth.signUpWithEmailPassword(
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
    // password dont match -> tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match"),
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
            "Let's create an account for you",
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
          // confirm password textfield
          const SizedBox(height: 10),
          CustomTextfieldWidget(
            controller: _confirmPasswordController,
            hintText: "Confirm password",
            obscureText: true,
          ),
          const SizedBox(height: 25),
          // login button
          CustomButton(
            text: "Register",
            onTap: () => register(context),
          ),

          const SizedBox(
            height: 25,
          ),

          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
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
