import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whizsoft_chat_app_machine_test/feature/home/view/pages/home_page.dart';

class SettingsPage extends StatelessWidget {
  static const routePath = "/settings";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go(HomePage.routePath);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Settings"),
        centerTitle: true,
      ),
    );
  }
}
